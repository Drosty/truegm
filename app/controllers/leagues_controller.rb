class LeaguesController < ApplicationController
  load_and_authorize_resource

  before_filter :set_current_league

  def set_current_league
    @current_league = League.find(params[:id]) if params[:id].present?
  end

  # GET /leagues
  # GET /leagues.json
  def index
    @leagues = current_user.leagues

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @leagues }
    end
  end

  # GET /leagues/1
  # GET /leagues/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @league }
    end
  end

end
