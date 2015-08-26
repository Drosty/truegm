# == Schema Information
#
# Table name: power_rankings
#
#  id          :integer          not null, primary key
#  team_id     :integer
#  description :text
#  rank        :integer
#  week        :integer
#  year        :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class PowerRanking < ActiveRecord::Base
  attr_accessible :description, :rank, :week, :year

  belongs_to :team

  validates_presence_of :description

end
