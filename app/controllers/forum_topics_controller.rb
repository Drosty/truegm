class ForumTopicsController < ApplicationController
  before_filter :ensure_user_logged_in
  before_filter :set_current_league
  before_filter :set_forum_topic, :except => [:index, :create]

  def set_current_league
    @current_league = League.find(params[:league_id]) if params[:league_id].present?
  end

  def set_forum_topic
    @forum_topic = ForumTopic.new
    @forum_topic = ForumTopic.find(params[:id]) if params[:id]
  end

  # GET /forum_topics
  # GET /forum_topics.json
  def index
    @forum_topics = @current_league.forum_topics
  end

  # GET /forum_topics/1
  # GET /forum_topics/1.json
  def show
    if @forum_topic.league_id != @current_league.id
      @forum_topic = nil
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

  # POST /forum_topics
  # POST /forum_topics.json
  def create
    @forum_topic = ForumTopic.new(params[:forum_topic])
    @forum_topic.league = @current_league

    respond_to do |format|
      if @forum_topic.save
        format.html { redirect_to league_forum_topic_path(@current_league, @forum_topic), notice: 'Forum topic was successfully created.' }
        format.json { render json: @forum_topic, status: :created, location: @forum_topic }
      else
        format.html { render "new" }
        format.json { render json: @forum_topic.errors, status: :unprocessable_entity }
      end
    end
  end

end
