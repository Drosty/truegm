module Admin
  class LeaguesController < BaseController

    before_action :set_admin_league, only: [:show, :edit, :update, :destroy]

    # GET /admin/leagues
    # GET /admin/leagues.json
    def index
      @admin_leagues = League.all
    end

    # GET /admin/leagues/1
    # GET /admin/leagues/1.json
    def show
    end

    # GET /admin/leagues/new
    def new
      @admin_league = League.new
    end

    # GET /admin/leagues/1/edit
    def edit
    end

    # POST /admin/leagues
    # POST /admin/leagues.json
    def create
      number_of_teams = params[:number_of_teams].to_i
      @admin_league = League.new(admin_league_params)

      # Create teams for the league
      number_of_teams.times do |n|
        team = Team.new
        team.name = "Team " + (n+1).to_s

        @admin_league.teams << team
      end

      respond_to do |format|
        if @admin_league.save
          format.html { redirect_to [:admin, @admin_league], notice: 'League was successfully created.' }
          format.json { render json: @admin_league, status: :created, location: @admin_league }
        else
          format.html { render "new" }
          format.json { render json: @admin_league.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /admin/leagues/1
    # PATCH/PUT /admin/leagues/1.json
    def update
      respond_to do |format|
        if @admin_league.update(admin_league_params)
          format.html { redirect_to [:admin, @admin_league], notice: 'League was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render :edit }
          format.json { render json: @admin_league.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /admin/leagues/1
    # DELETE /admin/leagues/1.json
    def destroy
      @admin_league.destroy
      respond_to do |format|
        format.html { redirect_to admin_leagues_url }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_admin_league
        @admin_league = League.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def admin_league_params
        params[:league]
      end
  end
end
