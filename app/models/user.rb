class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_voter
  
  belongs_to :team, optional:true
  has_many :track_likes, dependent: :destroy
  has_one_attached :avatar

  before_save :update_avatar, :update_phone
  after_create :send_welcome_mail

  attribute :team_name, :string
  attribute :team_short_name, :string
  attribute :team_checkout_limit, :integer
  attribute :invite_code, :string           #invite code for signing up

  scope :for_team_id, lambda {|query| where(["team_id = ?", "#{query.to_i}"])}

  def self.for_team(team_id)
    where("team_id = ?", team_id)
  end

  def update_phone
    pn = self.phone_number
    pn.remove!("+");
    pn.remove!(" ");
    pn.remove!("-");
    pn.remove!("(");
    pn.remove!(")");
    if pn.start_with?("1")
      pn[0] = ''
    end
    self.phone_number = pn
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
