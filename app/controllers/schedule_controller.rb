class ScheduleController < ApplicationController
  before_filter :ensure_user_logged_in
  before_filter :set_current_league

  def set_current_league
    @current_league = League.find(params[:league_id]) if params[:league_id].present?
  end

  def index
    raise Pundit::NotAuthorizedError.new("not authorized") unless LeaguePolicy.new(current_user, @current_league).show?

    week = params[:week].to_i
    week = current_week if week.nil? || week < 0 || week > 17
    year = ENV['current_year']

    nfl_matchups = NflMatchup.where(week: week, year: year)
    fantasy_matchups = Matchup.where(week: week, year: year)

  end

end
