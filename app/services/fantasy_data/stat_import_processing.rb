module FantasyData
  module StatImportProcessing

    def process_stats_for_player id
      stats_data_by_year = @fantasy_footbal_nerd_party.stats id

      process_multiple_years_of_stats stats_data_by_year
    end


    def process_multiple_years_of_stats year_of_stats_data
      year_of_stats_data.each do |year_of_stats|
        process_individual_year_of_stats year_of_stats
      end
    end

    def process_individual_year_of_stats year_of_data
      year_of_data[1].each do |actual_stat|
        process_stat actual_stat
      end
    end

    def process_stat stat_data
      stat_info = Import::Stat.new(stat_data[1])

      player = NflPlayer.find_by(nfl_data_id: stat_info.playerId)
      return if player.nil?

      db_stat = Stat.find_or_create_by(nfl_player_id: player.id,
                                       week: stat_info.week,
                                       year: stat_info.year)

      db_stat.opponent = stat_info.opponent
      db_stat.played = stat_info.gamePlayed == "1"
      db_stat.started = stat_info.gameStarted == "1"
      db_stat.final_score = stat_info.finalScore

      ## QB Things
      db_stat.passing_completions = stat_info.completions
      db_stat.passing_attempts = stat_info.passAttempts
      db_stat.passing_percentage = stat_info.percentage
      db_stat.passing_yards = stat_info.passYards
      db_stat.average_pass_yards = stat_info.avgPassYards
      db_stat.passing_touchdowns = stat_info.passTD
      db_stat.interceptions = stat_info.interceptions
      db_stat.qb_rating = stat_info.QBRating

      ## RB Things
      db_stat.rushing_attempts = stat_info.rushAttempts
      db_stat.rushing_yards = stat_info.rushYards
      db_stat.rushing_average = stat_info.rushAvg
      db_stat.rushing_touchdowns = stat_info.rushTD
      db_stat.fumbles = stat_info.fumble
      db_stat.fumbles_lost = stat_info.fumbleLost
      db_stat.long_run = stat_info.longRun

      ## WR Things
      db_stat.receptions = stat_info.receptions
      db_stat.receiving_yards = stat_info.recYards
      db_stat.receiving_average = stat_info.recAvg
      db_stat.receiving_long = stat_info.longRec

      db_stat.save
    end

  end

end
