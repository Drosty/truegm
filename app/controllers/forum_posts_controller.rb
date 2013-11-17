class ForumPostsController < ApplicationController
  load_and_authorize_resource

  before_filter :authenticate_user!
  before_filter :set_current_league

  def set_current_league
    @current_league = League.find(params[:league_id]) if params[:league_id].present?
    @current_topic = ForumTopic.find(params[:forum_topic_id]) if params[:forum_topic_id].present?

    @is_topic_in_current_league = @current_topic.league.id == @current_league.id 
  end

  # GET /forum_posts/new
  # GET /forum_posts/new.json
  def new
    respond_to do |format|
      if @is_topic_in_current_league
        format.html # new.html.erb
        format.json { render json: @forum_post }
      else
        format.html { redirect_to league_forum_topics_path(@current_league), notice: 'Not allowed to create this post.' }
        format.json { render json: @forum_post, status: :created, location: @forum_post }
      end
    end
  end

  # POST /forum_posts
  # POST /forum_posts.json
  def create
    @forum_post.forum_topic = @current_topic
    @forum_post.user = current_user

    respond_to do |format|
      if @is_topic_in_current_league && @forum_post.save
        format.html { redirect_to league_forum_topic_path(@current_league, @current_topic), notice: 'Forum post was successfully created.' }
        format.json { render json: @forum_post, status: :created, location: @forum_post }
      else
        format.html { render action: "new" }
        format.json { render json: @forum_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forum_posts/1
  # DELETE /forum_posts/1.json
  def destroy
    @forum_post.destroy if @is_topic_in_current_league

    respond_to do |format|
      format.html { redirect_to forum_posts_url }
      format.json { head :no_content }
    end
  end
end
