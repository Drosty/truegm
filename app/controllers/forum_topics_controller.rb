class ForumTopicsController < ApplicationController
  load_and_authorize_resource

  before_filter :set_current_league, only: [:index, :show, :edit, :new, :create, :update]

  def set_current_league
    @current_league = League.find(params[:league_id]) if params[:league_id].present?
    @current_team = Team.find(params[:id]) if params[:id].present?
  end

  # GET /forum_topics
  # GET /forum_topics.json
  def index
    @forum_topics = @current_league.forum_topics

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @forum_topics }
    end
  end

  # GET /forum_topics/1
  # GET /forum_topics/1.json
  def show
    respond_to do |format|
      if @forum_topic.league_id == @current_league.id
        format.html # show.html.erb
        format.json { render json: @forum_topic }
      else
        format.html { redirect_to league_forum_topics_path(@current_league), notice: 'Could not find Topic' }
        format.json { render json: 'Could not find topic', status: :unprocessable_entity }
      end
    end
  end

  # GET /forum_topics/new
  # GET /forum_topics/new.json
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @forum_topic }
    end
  end

  # GET /forum_topics/1/edit
  def edit
    if @forum_topic.league_id != @current_league.id
      redirect_to league_forum_topics_path(@current_league), notice: 'Could not find Topic'
    end
  end

  # POST /forum_topics
  # POST /forum_topics.json
  def create
    @forum_topic.league = @current_league

    respond_to do |format|
      if @forum_topic.save
        format.html { redirect_to league_forum_topic_path(@current_league, @forum_topic), notice: 'Forum topic was successfully created.' }
        format.json { render json: @forum_topic, status: :created, location: @forum_topic }
      else
        format.html { render action: "new" }
        format.json { render json: @forum_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /forum_topics/1
  # PUT /forum_topics/1.json
  def update
    respond_to do |format|
      if @forum_topic.update_attributes(params[:forum_topic])
        format.html { redirect_to league_forum_topics_path(@current_league), notice: 'Forum topic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @forum_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forum_topics/1
  # DELETE /forum_topics/1.json
  def destroy
    @forum_topic.destroy

    respond_to do |format|
      format.html { redirect_to league_forum_topics_path(@current_league) }
      format.json { head :no_content }
    end
  end
end
