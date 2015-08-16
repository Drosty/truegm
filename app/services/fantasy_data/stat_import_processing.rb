module FantasyData
  class StatImportProcessing

    def process_box_score stat_data
      week = stat_data.score.week
      season = stat_data.score.season

      # process_defense_stat stat_data["AwayFantasyDefense"], week, season
      # process_defense_stat stat_data["HomeFantasyDefense"], week, season

      stat_data.home_passing.each do |stat_line|
        process_passing_stat stat_line, week, season
      end

      stat_data.home_receiving.each do |stat_line|
        process_receiving_stat stat_line, week, season
      end

      stat_data.home_rushing.each do |stat_line|
        process_rushing_stat stat_line, week, season
      end

      stat_data.away_passing.each do |stat_line|
        process_passing_stat stat_line, week, season
      end

      stat_data.away_receiving.each do |stat_line|
        process_receiving_stat stat_line, week, season
      end

      stat_data.away_rushing.each do |stat_line|
        process_rushing_stat stat_line, week, season
      end

      stat_data.away_kicking.each do |stat_line|
        process_rushing_stat stat_line, week, season
      end

      stat_data.home_kicking.each do |stat_line|
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
      player = NflPlayer.find_by(fantasy_data_id: stat_info.player_id)
      db_stat = PassingStat.find_or_create_by({nfl_player_id: player.id, week: week, season: season})

      db_stat.init_from_import_model(stat_info)
      db_stat.save
    end

    def process_rushing_stat stat_info, week, season
      player = NflPlayer.find_by(fantasy_data_id: stat_info.player_id)
      db_stat = RushingStat.find_or_create_by({nfl_player_id: player.id, week: week, season: season})

      db_stat.init_from_import_model(stat_info)
      db_stat.save
    end

    def process_receiving_stat stat_info, week, season
      player = NflPlayer.find_by(fantasy_data_id: stat_info.player_id)
      db_stat = ReceivingStat.find_or_create_by({nfl_player_id: player.id, week: week, season: season})

      db_stat.init_from_import_model(stat_info)
      db_stat.save
    end

    def process_kicking_stat stat_info, week, season
      player = NflPlayer.find_by(fantasy_data_id: stat_info.player_id)
      db_stat = KickingStat.find_or_create_by({nfl_player_id: player.id, week: week, season: season})

      db_stat.init_from_import_model(stat_info)
      db_stat.save
    end

  end
end
