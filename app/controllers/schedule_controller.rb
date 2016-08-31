class ScheduleController < ApplicationController
  before_filter :ensure_user_logged_in
  before_filter :set_current_league

  def set_current_league
    @current_league = League.find(params[:league_id]) if params[:league_id].present?
  end

  def index

    week = params[:week].to_i
    week = current_week if week.nil? || week < 0 || week > 17
    year = ENV['current_year']

    nfl_matchups = NflMatchup.where(week: week, year: year)
    fantasy_matchups = Matchup.where(week: week, year: year)

    view_model = ScheduleViewModel.new(nfl_matchups, fantasy_matchups)
    render :locals => { :view_model => view_model }
  end

end
