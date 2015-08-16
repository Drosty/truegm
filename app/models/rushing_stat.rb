class RushingStat < ActiveRecord::Base
  include FantasyDataMapper

  belongs_to :nfl_matchup
  belongs_to :nfl_player
  belongs_to :nfl_team
end
