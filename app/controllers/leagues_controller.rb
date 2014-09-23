class LeaguesController < ApplicationController
  before_filter :ensure_user_logged_in
  after_filter :verify_policy_scoped, :only => :index

  # GET /leagues
  # GET /leagues.json
  def index
    @leagues = policy_scope(League)
  end

  # GET /leagues/1
  # GET /leagues/1.json
  def show
    @current_league = League.includes(:teams).find(params[:id]) if params[:id].present?
    authorize @current_league
  end

  def activity
    @page = params[:page]
    @perpage = 10
    @current_league = League.find(params[:league_id]) if params[:league_id].present?

    users = @current_league.get_user_ids
    @activities = PublicActivity::Activity.order("created_at desc")
                                          .where("owner_id in (?)", users)
                                          .paginate(:page => @page)
  end

end
