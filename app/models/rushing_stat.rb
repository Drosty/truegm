class RushingStat < ActiveRecord::Base
  include FantasyDataMapper

  attr_accessible :week, :season, :nfl_player_id

  belongs_to :nfl_matchup
  belongs_to :nfl_player
  belongs_to :nfl_team
end
