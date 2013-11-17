class ForumPost < ActiveRecord::Base
  attr_accessible :post_body

  belongs_to :user
  belongs_to :forum_topic, :counter_cache => :forumposts_count

  delegate :league, :to => :forum_topic, :allow_nil => false

  validates_presence_of :post_body
  validates_presence_of :forum_topic
end
