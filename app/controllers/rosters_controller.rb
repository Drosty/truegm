class RostersController < ApplicationController
  before_action :set_roster, only: [:show, :edit, :update, :destroy]

  # GET /rosters
  # GET /rosters.json
  def index
    @rosters = Roster.all
  end

  # GET /rosters/1
  # GET /rosters/1.json
  def show
  end

  # GET /rosters/new
  def new
    @roster = Roster.new
  end

  # GET /rosters/1/edit
  def edit
  end

  # POST /rosters
  # POST /rosters.json
  def create
    @roster = Roster.new(roster_params)

      if @roster.save
        redirect_to @roster, notice: 'Roster was successfully created.'
      else
        render action: 'new'
      end
  end

  # PATCH/PUT /rosters/1
  # PATCH/PUT /rosters/1.json
  def update
      if @roster.update(roster_params)
        redirect_to @roster, notice: 'Roster was successfully updated.'
      else
        render action: 'edit'
      end
  end

  # DELETE /rosters/1
  # DELETE /rosters/1.json
  def destroy
    @roster.destroy
    redirect_to rosters_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_roster
      @roster = Roster.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def roster_params
      params.require(:roster).permit(:name, :qb1, :rb1, :rb2, :wr1, :wr2, :te, :flex, :utility, :pk, :bench1, :bench2, :bench3, :bench4, :bench5, :bench6)
    end
end
