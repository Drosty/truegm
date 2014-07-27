class LeaguesController < ApplicationController
  before_filter :ensure_user_logged_in
  before_filter :set_current_league
  after_filter :verify_policy_scoped, :only => :index

  def set_current_league
    @current_league = League.find(params[:id]) if params[:id].present?
  end

  # GET /leagues
  # GET /leagues.json
  def index
    @leagues = policy_scope(League)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @leagues }
    end
  end

  # GET /leagues/1
  # GET /leagues/1.json
  def show
    authorize @current_league
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @league }
    end
  end

end
