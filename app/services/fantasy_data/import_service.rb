##
# This is the service that will make the calls to fantasy
# data and then process the data that is returned.  After
# making the call if will model the data and save it to
# the database correctly.
##
module FantasyData
  class ImportService
    attr_reader :fantasy_data_party

    def initialize(fantasy_data_party = FantasyDataParty.new)
      @fantasy_data_party = fantasy_data_party
    end

    def import_nfl_team_data
      teams = @fantasy_data_party.nfl_teams

      if was_unsuccessful_call(teams)
        print_error_message
        return
      end

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
        players = @fantasy_data_party.get_roster_players_for_team nfl_team.code

        if was_unsuccessful_call(players)
          print_error_message
          return
        end

        players.each do |player|
          next unless Position::ALL_POSITIONS.include?(player["FantasyPosition"].downcase)
          p_to_save = NflPlayer.find_or_create_by(fantasy_data_id: player["PlayerID"].to_i)

          p_to_save.active = player["Active"] == "true"
          p_to_save.jersey = player["Number"].to_i
          p_to_save.last_name = player["LastName"]
          p_to_save.first_name = player["FirstName"]
          p_to_save.full_name = player["Name"]
          p_to_save.nfl_team = nfl_team
          p_to_save.position = player["FantasyPosition"].downcase
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
      matchups = @fantasy_data_party.nfl_schedule "2014REG"

      if was_unsuccessful_call(matchups)
        print_error_message
        return
      end

      matchups.each do |matchup|
        db_matchup = NflMatchup.find_or_create_by(import_game_id: matchup["GameKey"].to_i,
                                                  week: matchup["Week"].to_i,
                                                  year: matchup["Season"].to_i)

        db_matchup.home_team = NflTeam.find_by(code: matchup["HomeTeam"])
        db_matchup.away_team = NflTeam.find_by(code: matchup["AwayTeam"])
        db_matchup.over_under = matchup["OverUnder"].to_f
        db_matchup.point_spread = matchup["PointSpread"].to_f

        # date is null on bye weeks in the schedule - so check this
        if matchup["Date"]
          Time.zone = 'Eastern Time (US & Canada)'
          db_matchup.game_date = Time.zone.parse(matchup["Date"]).utc
        end

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

    # this is going to be called for updates to errors etc,
    # as well as loading in the historical stats
    #
    # year in the format of 2014REG 2014POST, 2014PRE etc.
    # regular week is 1 based : 1 - 17
    # preseason week is 0 based : 0 - 4
    # postseason is 1 based : 1 - 4
    def import_weekly_stats year, week
      box_scores = @fantasy_data_party.weekly_stats(year, week)

      if was_unsuccessful_call(box_scores)
        print_error_message
        return
      end

      stat_processor = FantasyData::StatImportProcessing.new

      box_scores.each do |box_score|
        stat_processor.process_box_score(box_score)
      end
    end

    # this will be what is called for Real-Time stat importing
    def import_active_stats

    end

    private

      def was_unsuccessful_call obj
        obj.is_a?(Hash) && obj.has_key?("statusCode") && obj["statusCode"] != 200
      end

      def print_error_message
        puts "Status Code was not 200 when calling the FantasyDataParty"
      end

  end
end
