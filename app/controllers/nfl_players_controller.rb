class NflPlayersController < ApplicationController
  helper_method :sort_column, :sort_direction
  load_and_authorize_resource

  before_filter :set_current_league, only: [:show, :index]
  before_action :set_nfl_player, only: [:show, :edit, :update, :destroy]

  # GET /nfl_players
  # GET /nfl_players.json
  def index
    @nfl_players = NflPlayer.positions(position_selected).order(sort_column + " " + sort_direction).paginate(:page => params[:page])
  end

  # GET /nfl_players/1
  # GET /nfl_players/1.json
  def show
  end

  def sort_column 
    NflPlayer.column_names.include?(params[:sort]) ? params[:sort] : "salary"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

  def position_selected
    pos_param = params[:pos] == nil ? "all" : params[:pos].downcase
    NflPlayer.available_positions_for_filter.include?(pos_param) ? pos_param : "all" 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_nfl_player
      @nfl_player = NflPlayer.find(params[:id])
    end
    
    def set_current_league
      @current_league = League.find(params[:league_id]) if params[:league_id].present? 
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def nfl_player_params
      params[:nfl_player]
    end
end
