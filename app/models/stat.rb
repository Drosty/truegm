class Stat < ActiveRecord::Base
  attr_accessible :passing_yards, :passing_touchdowns, :interceptions,
                  :rushing_yards, :rushing_touchdowns, :receptions,
                  :receiving_yards, :receiving_touchdowns, :fumbles_lost,
                  :year, :week, :nfl_player_id

  belongs_to :nfl_player

  def summary
    "Week #{week} - 12 pts - #{passing_yards}/#{passing_touchdowns}/#{interceptions}"
  end

end
