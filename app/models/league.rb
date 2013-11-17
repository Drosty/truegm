class League < ActiveRecord::Base
  attr_accessible :description, :name, :tagline

  has_many :forum_topics
  has_many :teams

  validates_presence_of :tagline
  validates_length_of :name, :minimum => 5, :maximum => 20, :allow_blank => false
end
