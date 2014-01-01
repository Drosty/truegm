class PowerRanking < ActiveRecord::Base
  attr_accessible :description, :rank, :week, :year

  belongs_to :team

  validates_presence_of :description

end
