class NflPlayersController < ApplicationController
  helper_method :sort_column, :sort_direction

  before_filter :set_current_league, only: [:show, :index, :add_player, :remove_player]
  before_action :set_nfl_player, only: [:show, :edit, :update, :destroy, :add_player, :remove_player]

  # GET /nfl_players
  # GET /nfl_players.json
  def index
    @position = params[:position]
    @position = "all" if @position.blank?
    @position = @position.downcase

    @status = params[:own_status]
    @status = "Free Agent" if @status.blank?

    @searchString = params[:player_name]

    @page = params[:page]
    @perPage = NflPlayer.per_page

    @nfl_players = NflPlayer.search(@searchString)
                            .positions(@position)
                            .by_status(@status, @current_league)
                            .order(sort_column + " " + sort_direction)
                            .paginate(:page => @page)

    @total_players = @nfl_players.count
  end

  def add_player
    user_team = @current_league.teams.select { |t| t.user_id == current_user.id }.first

    @success = false

    if user_team && @nfl_player
      user_team.add_player @nfl_player
      @success = true
    end
  end

  def remove_player
    user_team = @current_league.teams.select { |t| t.user_id == current_user.id }.first

    @success = false

    if user_team && @nfl_player
      user_team.remove_player @nfl_player
      @success = true
    end
  end

  # GET /nfl_players/1
  # GET /nfl_players/1.json
  def show
    stats = Stat.where(nfl_player_id: @nfl_player.id)
                .where("year >= ?", 2013)
    view_model = NflPlayerViewModel.new(@nfl_player, stats)

    render :locals => { :view_model => view_model }
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
      @nfl_player = NflPlayer.includes(:stats).find(params[:id])
    end

    def set_current_league
      @current_league = League.find(params[:league_id]) if params[:league_id].present?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def nfl_player_params
      params[:nfl_player]
    end
end
