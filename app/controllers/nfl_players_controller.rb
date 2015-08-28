class NflPlayersController < ApplicationController
  before_filter :ensure_user_logged_in
  helper_method :sort_column, :sort_direction

  before_filter :set_current_league, only: [:show, :index, :add_player, :remove_player, :replace_players]
  before_action :set_nfl_player, only: [:show, :edit, :update, :destroy, :add_player, :remove_player, :replace_players]
  before_action :set_position, only: [:index]
  before_action :set_status, only: [:index]
  before_action :set_page, only: [:index]

  # GET /nfl_players
  # GET /nfl_players.json
  def index
    @searchString = params[:player_name]
    @perPage = NflPlayer.per_page

    @nfl_players = NflPlayer.search(@searchString)
                            .positions(@position)
                            .by_status(@status, @current_league)
                            .order(sort_column + " " + sort_direction + " NULLS LAST")
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

  # The NFL Player in the route is the player that will be added to the team
  # Then a NFL Player param passed in will be the player to be removed
  def replace_players
    user_team = @current_league.teams.select { |t| t.user_id == current_user.id }.first
    remove_player = NflPlayer.includes(:stats).find(params[:params][:remove_player_id])
    binding.pry

    if user_team && @nfl_player && remove_player
      user_team.remove_player remove_player
      user_team.add_player @nfl_player
      @success = true
    end
  end

  # GET /nfl_players/1
  # GET /nfl_players/1.json
  def show
    stats = Stat.where(nfl_player_id: @nfl_player.id)
                .where("year >= ?", 2013)
    view_model = NflPlayerViewModel.new(@nfl_player, stats, @current_league, current_user.team_in_league(@current_league))
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

    def set_position
      @position = params[:position]
      @position = "all" if @position.blank?
      @position = @position.downcase
    end

    def set_status
      @status = params[:own_status]
      @status = "Free Agent" if @status.blank?
    end

    def set_page
      @page = params[:page].to_i
      @page = 1 unless @page
      @page = 1 if @page < 1
    end

end
