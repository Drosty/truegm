class ForumPostsController < ApplicationController
  before_filter :ensure_user_logged_in
  before_filter :set_current_league
  before_filter :set_current_topic

  def set_current_league
    @current_league = League.find(params[:league_id]) if params[:league_id].present?
  end

  def set_current_topic
    @current_topic = ForumTopic.find(params[:forum_topic_id]) if params[:forum_topic_id].present?
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
    @forum_post = ForumPost.new
    @forum_post.forum_topic = @current_topic
    @forum_post.user = current_user
    @forum_post.post_body = params[:forum_post]

    @success = @forum_post.save
  end

end
