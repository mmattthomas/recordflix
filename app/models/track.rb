class Track < ApplicationRecord
  
  acts_as_votable

  belongs_to :posted_by, class_name: "User"
  belongs_to :team
  has_many :track_likes, dependent: :destroy

  validates :url, :presence => true
  scope :sorted, lambda { order("created_at DESC")}
  
  scope :feed_for_team_id, lambda {|query| where(["team_id = ?", "#{query.to_i}"])}
  
end
