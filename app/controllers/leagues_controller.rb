class LeaguesController < ApplicationController
  load_and_authorize_resource

  before_filter :set_current_league, only: [:show, :index, :edit, :new]
 
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

  # GET /leagues/new
  # GET /leagues/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @league }
    end
  end

  # GET /leagues/1/edit
  def edit
  end

  # POST /leagues
  # POST /leagues.json
  def create
    # Create 10 teams for the league
    10.times do |n|
      team = Team.new
      team.name = "Team " + (n+1).to_s

      if n == 0 then
        team.user = current_user
      end

      @league.teams << team
    end

    # Create the 3 Forum Topics - these shouldn't change
    ftOne = ForumTopic.new
    ftOne.name = 'Trades'
    ftOne.description = 'Discus Trades and Stuff'
    ftOne.league = @league

    ftTwo = ForumTopic.new
    ftTwo.name = 'General'
    ftTwo.description = 'Discus Anything that you want'
    ftTwo.league = @league

    ftThree = ForumTopic.new
    ftThree.name = 'Another One'
    ftThree.description = 'There is going to be something here'
    ftThree.league = @league

    @league.forum_topics << ftOne
    @league.forum_topics << ftTwo
    @league.forum_topics << ftThree

    respond_to do |format|
      if @league.save
        format.html { redirect_to @league, notice: 'League was successfully created.' }
        format.json { render json: @league, status: :created, location: @league }
      else
        format.html { render action: "new" }
        format.json { render json: @league.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /leagues/1
  # PUT /leagues/1.json
  def update
    respond_to do |format|
      if @league.update_attributes(params[:league])
        format.html { redirect_to @league, notice: 'League was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @league.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leagues/1
  # DELETE /leagues/1.json
  def destroy
    @league.destroy

    respond_to do |format|
      format.html { redirect_to leagues_url }
      format.json { head :no_content }
    end
  end
end
