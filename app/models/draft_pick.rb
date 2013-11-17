class DraftPick < ActiveRecord::Base
  attr_accessible :position, :round, :year

  belongs_to :original_team, :foreign_key => 'original_team_id', :class_name => "Team"
  belongs_to :current_team,  :foreign_key => 'team_id', :class_name => "Team"

  validates_presence_of :original_team, :current_team
  validates_presence_of :round, :year, :position
end
