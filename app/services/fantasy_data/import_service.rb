##
# This is the service that will make the calls to fantasy
# data and then process the data that is returned.  After
# making the call if will model the data and save it to
# the database correctly.
##
module FantasyData
  class ImportService

    def import_nfl_team_data
      Fantasydata.teams_active.each do |team|
        in_team = NflTeam.find_or_create_by(code: team.key,
                                  full_name: team.full_name,
                                  short_name: team.name) do |t|

          t.bye_week = team.bye_week
        end
      end
    end

    def import_nfl_player_data
      NflPlayer.update_all(active: false)
      teams = NflTeam.all

      Fantasydata.player_details_available.each do |player|
        next unless Position::ALL_POSITIONS.include?(player.fantasy_position.downcase)
        NflPlayer.find_or_create_by(fantasy_data_id: player.player_id) do |p|
          p.active = player.active
          p.jersey = player.number
          p.last_name = player.last_name
          p.first_name = player.first_name
          p.full_name = player.name
          p.nfl_team = teams.select { |team| team.code == player.current_team }.first
          p.position = player.fantasy_position
          p.height = player.height
          p.weight = player.weight
          p.college = player.college
          p.current_status = player.current_status
          p.depth_order = player.depth_order
          p.experience = player.experience
          p.photo_url = player.photo_url

          begin
            p.dob = player.birth_date.to_datetime
          rescue => e
            p.dob = nil
          end
        end
      end
    end

    def import_nfl_schedule
      current_year = Fantasydata.current_season
      Fantasydata.schedule_by_year(current_year).each do |matchup|
        db_matchup = NflMatchup.find_or_create_by(import_game_id: matchup.game_key,
                                                  week: matchup.week,
                                                  year: matchup.season)

        db_matchup.home_team = NflTeam.find_by(code: matchup.home_team)
        db_matchup.away_team = NflTeam.find_by(code: matchup.away_team)
        db_matchup.over_under = matchup.over_under
        db_matchup.point_spread = matchup.point_spread

        # date is null on bye weeks in the schedule - so check this
        if matchup.date
          Time.zone = 'Eastern Time (US & Canada)'
          db_matchup.game_date = Time.zone.parse(matchup.date).utc
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
