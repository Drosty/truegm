class PassingStat < ActiveRecord::Base
  belongs_to :nfl_matchup
  belongs_to :nfl_player
  belongs_to :nfl_team
end
