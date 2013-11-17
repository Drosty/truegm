class ForumTopic < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :forum_posts
  belongs_to :league

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :league
end
