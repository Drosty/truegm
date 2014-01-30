class ForumTopic < ActiveRecord::Base
  default_scope { order('updated_at desc') }
  attr_accessible :description, :name

  has_many :forum_posts
  belongs_to :league
  belongs_to :user

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :league
end
