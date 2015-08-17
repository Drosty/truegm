# == Schema Information
#
# Table name: forum_topics
#
#  id               :integer          not null, primary key
#  league_id        :integer
#  name             :string
#  description      :text
#  created_at       :datetime
#  updated_at       :datetime
#  forumposts_count :integer          default(0)
#  user_id          :integer
#

class ForumTopic < ActiveRecord::Base
  include PublicActivity::Common

  default_scope { order('updated_at desc') }
  attr_accessible :description, :name, :user_id, :league_id

  has_many :forum_posts, :dependent => :destroy
  belongs_to :league
  belongs_to :user

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :league
end
