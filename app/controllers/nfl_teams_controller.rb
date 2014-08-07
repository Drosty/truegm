class NflTeamsController < ApplicationController

  before_filter :set_current_league, only: [:show]
  before_filter :set_nfl_team, only: [:show]

  def show
    @players_on_team = NflPlayer.where(nfl_team_id: @nfl_team.id)
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_nfl_team
      @nfl_team = NflTeam.find(params[:id])
    end

    def set_current_league
      @current_league = League.find(params[:league_id]) if params[:league_id].present?
    end

end
