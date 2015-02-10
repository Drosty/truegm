module Admin
  class TeamsController < BaseController

    before_action :set_admin_team, only: [:show, :edit, :update, :destroy]

    # PUT /admin/team/:team_id/add/:player_id
    def player_add
      team = Team.find(params[:team_id])
      player = NflPlayer.find(params[:player][:player_id])

      if team && player
        team.add_player player
      end
      redirect_to(edit_admin_team_path(team))
    end

    # PUT /admin/team/:team_id/remove/:player_id
    def player_remove
      team = Team.find(params[:team_id])
      player = NflPlayer.find(params[:player_id])
      league = team.league

      team.nfl_players.delete(player)
      team.save
      redirect_to(edit_admin_team_path(team))
    end

    # GET /admin/teams
    # GET /admin/teams.json
    def index
      league = League.find(params[:league_id])
      @league_name = league.name
      @admin_teams = Team.where(league: league)
    end

    # GET /admin/teams/1
    # GET /admin/teams/1.json
    def show
    end

    # GET /admin/teams/1/edit
    def edit
      @invite = Invite.new
      @invite.team_id = @admin_team.id
    end

    # PATCH/PUT /admin/teams/1
    # PATCH/PUT /admin/teams/1.json
    def update
      respond_to do |format|
        if @admin_team.update(admin_team_params)
          format.html { redirect_to admin_team_path(@admin_team), notice: 'Team was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render :edit }
          format.json { render json: @admin_team.errors, status: :unprocessable_entity }
        end
      end
    end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_admin_team
      @admin_team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_team_params
      params[:team]
    end

  end

end
