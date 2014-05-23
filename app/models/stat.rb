class Stat < ActiveRecord::Base
  attr_accessible :passing_yards, :passing_touchdowns, :interceptions,
                  :rushing_yards, :rushing_touchdowns, :receptions,
                  :receiving_yards, :receiving_touchdowns, :fumbles_lost,
                  :year, :week, :nfl_player_id

  belongs_to :nfl_player

  def total_points
    @total_points ||= begin
      [
        (passing_yards.to_f / 25).round(2),
        passing_touchdowns * 5,
        -(interceptions * 2),
        -(fumbles_lost * 2),
        rushing_yards.to_f / 10,
        rushing_touchdowns * 6,
        receiving_yards.to_f / 10,
        receiving_touchdowns * 6,
        receptions
      ].sum.round(2)
    end
  end

  def summary position = "qb"
    case position
    when "qb"
      summary = "Week #{week} - #{self.total_points} pts - #{passing_yards} / #{passing_touchdowns} / #{interceptions}"
    when "rb"
      summary = "Week #{week} - #{self.total_points} pts - #{rushing_yards} yds / #{rushing_touchdowns} tds"
    when "wr", "te"
      summary = "Week #{week} - #{self.total_points} pts - #{rushing_yards} yds / #{rushing_touchdowns} tds"
    end

    summary
  end

  def position_specific_stats position = "qb"
    case position
    when "qb"
      stats = get_stats_for_qb
    when "rb"
      stats = get_stats_for_rb
    when "wr", "te"
      stats = get_stats_for_wr_or_te
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

    def get_stats_for_rb
      {
        :rushing_yards => self.rushing_yards,
        :rushing_touchdown => self.rushing_touchdowns,
        :receptions => self.receptions,
        :receiving_yards => self.receiving_yards,
        :receiving_touchdowns => self.receiving_touchdowns,
        :fumbles_lost => self.fumbles_lost
      }
    end

    def get_stats_for_wr_or_te
      {
        :receiving_yards => self.receiving_yards,
        :receiving_touchdowns => self.receiving_touchdowns,
        :rushing_yards => self.rushing_yards,
        :rushing_touchdown => self.rushing_touchdowns,
        :receptions => self.receptions,
        :fumbles_lost => self.fumbles_lost
      }
    end

end
