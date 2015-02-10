module FantasyData
  class StatImportProcessing

    def process_box_score stat_data
      week = stat_data["Score"]["Week"].to_i
      season = stat_data["Score"]["Season"].to_i

      # process_defense_stat stat_data["AwayFantasyDefense"], week, season
      # process_defense_stat stat_data["HomeFantasyDefense"], week, season

      stat_data["HomePassing"].each do |stat_line|
        process_passing_stat stat_line, week, season
      end

      stat_data["HomeReceiving"].each do |stat_line|
        process_receiving_stat stat_line, week, season
      end

      stat_data["HomeRushing"].each do |stat_line|
        process_rushing_stat stat_line, week, season
      end

      stat_data["AwayPassing"].each do |stat_line|
        process_passing_stat stat_line, week, season
      end

      stat_data["AwayReceiving"].each do |stat_line|
        process_receiving_stat stat_line, week, season
      end

      stat_data["AwayRushing"].each do |stat_line|
        process_rushing_stat stat_line, week, season
      end
    end

    private

    def process_defense_stat stat_info, week, season
      # TODO
      db_stat = get_stat_record(stat_info["PlayerID"], week, season)
      return if db_stat.nil?

    end

    def process_passing_stat stat_info, week, season
      db_stat = get_stat_record(stat_info["PlayerID"], week, season)
      return if db_stat.nil?

      db_stat.passing_completions = stat_info["PassingCompletions"].to_i
      db_stat.passing_attempts = stat_info["PassingAttempts"].to_i
      db_stat.passing_percentage = stat_info["PassingCompletionPercentage"].to_f
      db_stat.passing_yards = stat_info["PassingYards"].to_i
      db_stat.passing_touchdowns = stat_info["PassingTouchdowns"].to_i
      db_stat.passing_interceptions = stat_info["PassingInterceptions"].to_i
      db_stat.qb_rating = stat_info["PassingRating"].to_f
      db_stat.passing_sacks = stat_info["PassingSacks"].to_i

      db_stat.save
    end

    def process_rushing_stat stat_info, week, season
      db_stat = get_stat_record(stat_info["PlayerID"], week, season)
      return if db_stat.nil?

      db_stat.rushing_attempts = stat_info["RushingAttempts"].to_i
      db_stat.rushing_yards = stat_info["RushingYards"].to_i
      db_stat.rushing_average = stat_info["RushingYardsPerAttempt"].to_i
      db_stat.rushing_touchdowns = stat_info["RushingTouchdowns"].to_i
      db_stat.fumbles_lost = stat_info["FumblesLost"].to_i
      db_stat.long_run = stat_info["RushingLong"].to_i
      db_stat.two_point_conversion_runs = stat_info["TwoPointConversionRuns"].to_i

      db_stat.save
    end

    def process_receiving_stat stat_info, week, season
      db_stat = get_stat_record(stat_info["PlayerID"], week, season)
      return if db_stat.nil?

      db_stat.receiving_targets = stat_info["ReceivingTargets"].to_i
      db_stat.receptions = stat_info["Receptions"].to_i
      db_stat.receiving_yards = stat_info["ReceivingYards"].to_i
      db_stat.two_point_conversion_receptions = stat_info["TwoPointConversionReceptions"].to_i
      db_stat.receiving_long = stat_info["ReceivingLong"].to_i
      db_stat.receiving_touchdowns = stat_info["ReceivingTouchdowns"].to_i
      db_stat.fumbles_lost = stat_info["FumblesLost"].to_i

      db_stat.save
    end

    def get_stat_record fantasy_data_player_id, week, season
      player = NflPlayer.find_by(fantasy_data_id: fantasy_data_player_id)
      # raise "fantasy player not found #{fantasy_data_player_id}" if player.nil?
      return nil if player.nil?

      Stat.find_or_create_by(nfl_player_id: player.id,
                             week: week,
                             year: season)
    end
  end
end
