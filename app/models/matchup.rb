# == Schema Information
#
# Table name: matchups
#
#  id           :integer          not null, primary key
#  year         :integer
#  week         :integer
#  home_team_id :integer
#  away_team_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Matchup < ActiveRecord::Base
  attr_accessible :week, :year

	belongs_to :away_team, :foreign_key => 'away_team_id', :class_name => "Team"
	belongs_to :home_team, :foreign_key => 'home_team_id', :class_name => "Team"
end
