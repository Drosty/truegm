class TeamsController < ApplicationController
  before_filter :set_current_team
  before_filter :set_current_league

  def set_current_team
    @team = Team.find(params[:id]) if params[:id].present?
  end

  def set_current_league
    @current_league = @team.league
  end

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @team }
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
        format.html { redirect_to team_path(@team), notice: 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render "edit" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end
end
