require 'csv'

module FantasyData
  class ImportService
    include FantasyData::StatImportProcessing

    attr_reader :fantasy_footbal_nerd_party

    def initialize(fantasy_football_party = FantasFootballNerdParty.new)
      @fantasy_footbal_nerd_party = fantasy_football_party
    end

    def import_nfl_team_data
      teams = @fantasy_footbal_nerd_party.nfl_teams

      teams.each do |team|
        NflTeam.find_or_create_by(code: team.code,
                                  full_name: team.fullName,
                                  short_name: team.shortName)
      end
    end

    def import_nfl_player_data position
      players = @fantasy_footbal_nerd_party.nfl_players position
      NflPlayer.update_all(active: false)

      players.each do |player|
        p_to_save = NflPlayer.find_or_create_by(nfl_data_id: player.playerId)

        p_to_save.active = player.active == "1"
        p_to_save.jersey = player.jersey
        p_to_save.last_name = player.lname
        p_to_save.first_name = player.fname
        p_to_save.full_name = player.displayName
        p_to_save.nfl_team = NflTeam.find_by(code: player.team)
        p_to_save.position = player.position
        p_to_save.height = player.height
        p_to_save.weight = player.weight
        p_to_save.college = player.college

        begin
          p_to_save.dob = player.dob.to_datetime
        rescue => e
          p_to_save.dob = nil
        end

        p_to_save.save
      end
    end

    def import_nfl_schedule
      matchups = @fantasy_footbal_nerd_party.nfl_schedule

      matchups.each do |matchup|
        db_matchup = NflMatchup.find_or_create_by(import_game_id: matchup.gameId, week: matchup.gameWeek)

        db_matchup.home_team = NflTeam.find_by(code: matchup.homeTeam)
        db_matchup.away_team = NflTeam.find_by(code: matchup.awayTeam)
        db_matchup.tv_station = matchup.tvStation
        db_matchup.game_date = Time.parse(matchup.gameDate + " " + matchup.gameTimeET).utc

        db_matchup.save
      end
    end

    def import_injury_status

    end

    def import_draft_rankings

    end

    def remove_draft_rankings

    end

    def import_weekly_rankings

    end

    def import_weekly_projections

    end

    def import_depth_chart_data

    end

    def import_game_day_inactives

    end

    def import_stats
      NflPlayer.all.each do |nfl_player|
        process_stats_for_player nfl_player.nfl_data_id
      end
    end

  end

end
