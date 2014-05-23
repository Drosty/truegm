class Stat < ActiveRecord::Base
  attr_accessible :passing_yards, :passing_touchdowns, :interceptions,
                  :rushing_yards, :rushing_touchdowns, :receptions,
                  :receiving_yards, :receiving_touchdowns, :fumbles_lost,
                  :year, :week, :nfl_player_id

  belongs_to :nfl_player

  def summary
    "Week #{week} - 12 pts - #{passing_yards}/#{passing_touchdowns}/#{interceptions}"
  end

  def position_specific_stats position
    case position
    when "qb"
      stats = get_stats_for_qb
    when "rb", "wr", "te"
      stats = get_stats_for_skill_player
    end

    stats
  end

  private

    def get_stats_for_qb
      {
        :passing_yards => self.passing_yards,
        :passing_touchdowns => self.passing_touchdowns,
        :interceptions => self.interceptions,
        :rushing_yards => self.rushing_yards,
        :rushing_touchdown => self.rushing_touchdowns,
        :fumbles_lost => self.fumbles_lost
      }
    end

    def get_stats_for_skill_player
      {
        :rushing_yards => self.rushing_yards,
        :rushing_touchdown => self.rushing_touchdowns,
        :receptions => self.receptions,
        :receiving_yards => self.receiving_yards,
        :receiving_touchdowns => self.receiving_touchdowns,
        :fumbles_lost => self.fumbles_lost
      }
    end

end
