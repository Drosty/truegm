##
# This is the service that will make the calls to fantasy
# data and then process the data that is returned.  After
# making the call if will model the data and save it to
# the database correctly.
##
module FantasyData
  class ImportService
    include FantasyData::StatImportProcessing

    attr_reader :fantasy_data_party

    def initialize(fantasy_data_party = FantasyDataParty.new)
      @fantasy_data_party = fantasy_data_party
    end

    def import_nfl_team_data
      teams = @fantasy_data_party.nfl_teams

      teams.each do |team|
        in_team = NflTeam.find_or_create_by(code: team["Key"],
                                  full_name: team["FullName"],
                                  short_name: team["Name"])

        in_team.bye_week = team["ByeWeek"]
        in_team.save
      end
    end

    def import_nfl_player_data position
      NflPlayer.update_all(active: false)

      NflTeam.all.each do |nfl_team|
        puts "processing #{nfl_team.code}"
        players = @fantasy_data_party.get_roster_players_for_team nfl_team.code
        players.each do |player|
          p_to_save = NflPlayer.find_or_create_by(fantasy_data_id: player["PlayerID"].to_i)

          p_to_save.active = player["Active"] == "true"
          p_to_save.jersey = player["Number"].to_i
          p_to_save.last_name = player["LastName"]
          p_to_save.first_name = player["FirstName"]
          p_to_save.full_name = player["Name"]
          p_to_save.nfl_team = nfl_team
          p_to_save.position = player["FantasyPosition"]
          p_to_save.height = player["Height"]
          p_to_save.weight = player["Weight"]
          p_to_save.college = player["College"]
          p_to_save.current_status = player["CurrentStatus"]
          p_to_save.depth_order = player["DepthOrder"].to_i
          p_to_save.experience = player["Experience"].to_i
          p_to_save.photo_url = player["PhotoUrl"]

          begin
            p_to_save.dob = player["BirthDate"].to_datetime
          rescue => e
            p_to_save.dob = nil
          end

          p_to_save.save
        end
      end
    end

    def import_nfl_schedule
      matchups = @fantasy_data_party.nfl_schedule

      matchups.each do |matchup|
        db_matchup = NflMatchup.find_or_create_by(import_game_id: matchup.gameId,
                                                  week: matchup.gameWeek,
                                                  year: ENV['current_year'])

        db_matchup.home_team = NflTeam.find_by(code: matchup.homeTeam)
        db_matchup.away_team = NflTeam.find_by(code: matchup.awayTeam)
        db_matchup.tv_station = matchup.tvStation

        Time.zone = 'Eastern Time (US & Canada)'
        db_matchup.game_date = Time.zone.parse(matchup.gameDate + " " + matchup.gameTimeET).utc

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

    # this imports from Fantasy Football Nerd.
    # I don't have an API key for this but code is
    # written with the test API key.  IF I ever
    # purchase this I can use this endpoint.
    # For now commenting out because I DON'T want
    # this to run if it is accidentally called
    def import_stats
      puts "Shouldn't be calling this."
      # NflPlayer.all.each do |nfl_player|
      #  process_stats_for_player nfl_player.nfl_data_id
      # end
    end
  end
end
