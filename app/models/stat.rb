class Stat < ActiveRecord::Base
  attr_accessible :passing_yards, :passing_touchdowns, :interceptions,
                  :rushing_yards, :rushing_touchdowns, :receptions,
                  :receiving_yards, :receiving_touchdowns, :fumbles_lost,
                  :year, :week, :nfl_player_id

  belongs_to :nfl_player

  default_scope { includes(:nfl_player) }

  validates_presence_of :week, :year, :nfl_player_id

  def total_points
    @total_points ||= begin
      [
        (passing_yards.to_f / 25).round(2),
        passing_touchdowns.to_i * 5,
        -(interceptions.to_i * 2),
        -(fumbles_lost.to_i * 2),
        rushing_yards.to_f / 10.0,
        rushing_touchdowns.to_i * 6,
        receiving_yards.to_f / 10.0,
        receiving_touchdowns.to_i * 6,
        receptions.to_i,

        defensive_interceptions.to_i * 2,
        fumbles_recovered.to_i * 2,
        sacks.to_i * 1,
        safties.to_i * 2,
        defensive_tds.to_i * 6,
        defensive_points_allowed_points
      ].sum.round(2)
    end
  end

  def summary
    case nfl_player.position
    when "QB"
      summary = "Week #{week} - #{total_points} pts - #{passing_yards} / #{passing_touchdowns} / #{interceptions}"
    when "RB"
      summary = "Week #{week} - #{total_points} pts - #{rushing_yards} yds / #{rushing_touchdowns} tds"
    when "WR", "TE"
      summary = "Week #{week} - #{total_points} pts - #{receiving_yards} yds / #{receiving_touchdowns} tds"
    when "DEF"
      summary = "Week #{week} - #{total_points} fantasy pts"
    end

    summary
  end

  def position_specific_stats
    stats = []
    case nfl_player.position
    when "QB"
      stats = get_stats_for_qb
    when "RB"
      stats = get_stats_for_rb
    when "WR", "TE"
      stats = get_stats_for_wr_or_te
    when "DEF"
      stats = get_stats_for_def
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
        :receptions => self.receptions,
        :receiving_yards => self.receiving_yards,
        :receiving_touchdowns => self.receiving_touchdowns,
        :rushing_yards => self.rushing_yards,
        :rushing_touchdown => self.rushing_touchdowns,
        :fumbles_lost => self.fumbles_lost
      }
    end

    def get_stats_for_def
      {
        :points_allowed => self.points_allowed,
        :sacks => self.sacks,
        :interceptions => self.defensive_interceptions,
        :fumbles_recovered => self.fumbles_recovered,
        :defensive_touchdowns => self.defensive_tds,
        :returned_touchdowns => self.return_tds,
        :safties => self.safties
      }
    end

    def defensive_points_allowed_points
      return 0 if nfl_player.nil?
      return 0 unless nfl_player.position == "DEF"

      if self.points_allowed.to_i <= 6
        return 10
      end

      if self.points_allowed.to_i <= 13
        return 7
      end

      if self.points_allowed.to_i <= 20
        return 1
      end

      if self.points_allowed.to_i <= 27
        return 0
      end

      if self.points_allowed.to_i <= 34
        return -1
      end

      -4
    end

end
