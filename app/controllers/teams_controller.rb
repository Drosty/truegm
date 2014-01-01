class TeamsController < ApplicationController
  load_and_authorize_resource
  before_filter :set_current_league

  def set_current_league
    @current_league = League.find(params[:league_id]) if params[:league_id].present?
  end

  def show
    respond_to do |format|
      if @current_league.teams.include?(@team)
        format.html # show.html.erb
        format.json { render json: @team }
      else
        format.html { redirect_to league_path(@current_league), notice: 'Could not find team in league' }
        format.json { head :no_content }
      end
    end
  end

  def edit
    respond_to do |format|
        format.html
    end
  end

  def update
    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to league_team_path(@current_league, @team), notice: 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render "edit" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end
end
