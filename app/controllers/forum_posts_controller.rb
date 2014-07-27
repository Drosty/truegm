class ForumPostsController < ApplicationController
  before_filter :ensure_user_logged_in
  before_filter :set_current_league
  before_filter :set_current_topic
  before_filter :set_recent_posts

  def set_current_league
    @current_league = League.find(params[:league_id]) if params[:league_id].present?
  end

  def set_current_topic
    @current_topic = ForumTopic.find(params[:forum_topic_id]) if params[:forum_topic_id].present?
  end

  def set_recent_posts
    @recent_posts = @current_topic.forum_posts.order(created_at: :desc).limit(3)
    @recent_posts.reverse!
  end

  # GET /forum_posts/new
  # GET /forum_posts/new.json
  def new
    @forum_post = ForumPost.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @forum_post }
    end
  end

  # POST /forum_posts
  # POST /forum_posts.json
  def create
    @forum_post = ForumPost.new(params[:forum_post])
    @forum_post.forum_topic = @current_topic
    @forum_post.user = current_user

    respond_to do |format|
      if @forum_post.save
        format.html { redirect_to league_forum_topic_path(@current_league, @current_topic), notice: 'Forum post was successfully created.' }
        format.json { render json: @forum_post, status: :created, location: @forum_post }
      else
        format.html { render "new" }
        format.json { render json: @forum_post.errors, status: :unprocessable_entity }
      end
    end
  end

end
