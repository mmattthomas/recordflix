class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :team, optional:true
  has_many :track_likes, dependent: :destroy

  before_save :update_avatar

  after_create :send_welcome_mail

  attribute :team_name, :string
  attribute :team_short_name, :string
  attribute :team_checkout_limit, :integer

  def self.for_team(team_id)
    where("team_id = ?", team_id)
  end

  def update_avatar
    if self.avatar_url.nil?
      email_address = self.email.downcase
      hash = Digest::MD5.hexdigest(email_address)
  
      # compile URL which can be used in <img src="RIGHT_HERE"...
      image_src = "https://www.gravatar.com/avatar/#{hash}"
      self.avatar_url = image_src
    end
  end

  def send_welcome_mail
    UserMailer.with(user: self, team: self.team).welcome_email.deliver_later
  end

end
