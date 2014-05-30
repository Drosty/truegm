class NflMatchup < ActiveRecord::Base
  attr_accessible :import_game_id, :week, :game_date,
                  :away_team_id, :home_team_id, :tv_station

  belongs_to :away_team, :foreign_key => 'away_team_id', :class_name => "NflTeam"
  belongs_to :home_team, :foreign_key => 'home_team_id', :class_name => "NflTeam"
  
end
