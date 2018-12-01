class Track < ApplicationRecord
  
  belongs_to :posted_by, class_name: "User"
  belongs_to :team

  has_many :track_likes, dependent: :destroy

  scope :sorted, lambda { order("created_at DESC")}
  
end
