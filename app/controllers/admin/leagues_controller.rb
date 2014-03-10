module Admin
  class LeaguesController < BaseController
    load_and_authorize_resource
  
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
      # Create 10 teams for the league
      10.times do |n|
        team = Team.new
        team.name = "Team " + (n+1).to_s
  
        @league.teams << team
      end
  
      respond_to do |format|
        if @league.save
          format.html { redirect_to [:admin, @league], notice: 'League was successfully created.' }
          format.json { render json: @league, status: :created, location: @league }
        else
          format.html { render "new" }
          format.json { render json: @league.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PATCH/PUT /admin/leagues/1
    # PATCH/PUT /admin/leagues/1.json
    def update
      respond_to do |format|
        if @league.update(admin_league_params)
          format.html { redirect_to [:admin, @league], notice: 'League was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render :edit }
          format.json { render json: @league.errors, status: :unprocessable_entity }
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
