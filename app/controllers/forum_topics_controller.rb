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

  # POST /forum_topics
  # POST /forum_topics.json
  def create
    @forum_topic = ForumTopic.new(params[:forum_topic])
    @forum_topic.league = @current_league

    @success = @forum_topic.save
    NewForumTopicWorker.perform_async(@forum_topic.id) if @success
  end

end
