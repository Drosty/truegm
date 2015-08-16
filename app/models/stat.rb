# GOING TO DELETE AND USE THE SEPARATE STATS TABLES CREATED
class Stat < ActiveRecord::Base
  attr_accessible :passing_yards, :passing_touchdowns, :passing_interceptions,
                  :rushing_yards, :rushing_touchdowns, :receptions,
                  :receiving_yards, :receiving_touchdowns, :fumbles_lost,
                  :year, :week, :nfl_player_id

  belongs_to :nfl_player

  validates_presence_of :week, :year, :nfl_player_id

  def total_points league
    [
      (passing_yards.to_f * league.passing_yard_points).round(2),
      passing_touchdowns.to_i * league.passing_touchdown_points,
      passing_interceptions.to_i * league.passing_interception_points,
      fumbles_lost.to_i * league.fumbles_lost_points,
      rushing_yards.to_f * league.rushing_yards_points,
      rushing_touchdowns.to_i * league.rushing_touchdown_points,
      receiving_yards.to_f * league.receiving_yards_points,
      receiving_touchdowns.to_i * league.receiving_touchdown_points,
      receptions.to_i * league.points_per_reception_points,

      defensive_interceptions.to_i * league.defensive_interception_points,
      fumbles_recovered.to_i * league.defensive_fumble_recovered_points,
      defensive_sacks.to_i * league.defensive_sack_points,
      safties.to_i * league.defensive_saftey_points,
      defensive_tds.to_i * league.defensive_touchdown_points,
      defensive_points_allowed_points(league)
    ].sum.round(2)
  end

  def summary
    case nfl_player.position
    when Position::QUARTERBACK
      summary = "#{passing_yards} yards / #{passing_touchdowns} TDs / #{passing_interceptions} INTs"
    when Position::RUNNINGBACK
      summary = "#{rushing_yards} yards / #{rushing_touchdowns} TDs"
    when Position::WIDERECEIVER, Position::TIGHTEND
      summary = "#{receptions} rec / #{receiving_yards} yards / #{receiving_touchdowns} TDs"
    when Position::DEFENSE
      summary = "defensive stats"
    end

    summary
  end

  def position_specific_stats
    stats = []
    case nfl_player.position
    when Position::QUARTERBACK
      stats = get_stats_for_qb
    when Position::RUNNINGBACK
      stats = get_stats_for_rb
    when Position::WIDERECEIVER, Position::TIGHTEND
      stats = get_stats_for_wr_or_te
    when Position::DEFENSE
      stats = get_stats_for_def
    end

    stats
  end

  private

    def get_stats_for_qb
      {
        :passing_yards => self.passing_yards,
        :passing_touchdowns => self.passing_touchdowns,
        :interceptions => self.passing_interceptions,
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
        :sacks => self.defensive_sacks,
        :interceptions => self.defensive_interceptions,
        :fumbles_recovered => self.fumbles_recovered,
        :defensive_touchdowns => self.defensive_tds,
        :returned_touchdowns => self.return_tds,
        :safties => self.safties
      }
    end

    def defensive_points_allowed_points league
      return 0 if nfl_player.nil?
      return 0 unless nfl_player.position.upcase == "DEF"

      if self.points_allowed.to_i < 7
        return league.defensive_points_allowed_under_7_points
      end

      if self.points_allowed.to_i < 14
        return league.defensive_points_allowed_under_14_points
      end

      if self.points_allowed.to_i < 21
        return league.defensive_points_allowed_under_21_points
      end

      if self.points_allowed.to_i < 28
        return league.defensive_points_allowed_under_28_points
      end

      if self.points_allowed.to_i < 35
        return league.defensive_points_allowed_under_35_points
      end

      league.defensive_points_allowed_equal_or_over_35_points
    end

end
