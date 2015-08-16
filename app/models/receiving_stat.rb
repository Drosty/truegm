class ReceivingStat < ActiveRecord::Base
  include FantasyDataMapper
  
  attr_accessible :number, :position, :position_category, :fantasy_position, 
                  :fantasy_points, :fumbles_lost, :receiving_long, 
                  :receiving_targets, :receiving_touchdowns, :receiving_yards, 
                  :receiving_yards_per_reception, :receiving_yards_per_target, 
                  :reception_percentage, :receptions, :two_point_conversion_receptions

  belongs_to :nfl_matchup
  belongs_to :nfl_player
  belongs_to :nfl_team
end
