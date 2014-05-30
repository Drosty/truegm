require 'csv'

module FantasyData
  class ImportService
    attr_reader :fantasy_footbal_nerd_party

    def initialize(fantasy_football_party = FantasFootballNerdParty.new)
      @fantasy_footbal_nerd_party = fantasy_football_party
    end

    def import_nfl_team_data
      teams = @fantasy_footbal_nerd_party.nfl_teams

      teams.each do |team|
        NflTeam.find_or_create_by(code: team["code"],
                                  full_name: team["fullName"],
                                  short_name: team["shortName"])
      end
    end

    def import_player_data

    end

    def import_nfl_schedule

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

    end

  end

end
