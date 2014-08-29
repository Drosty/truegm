class NewForumPostWorker
  include Sidekiq::Worker

  def perform(post_id)
    post = ForumPost.find_by(id: post_id)
    topic = post.forum_topic
    emails = []

    topic.forum_posts.each do |t|
      unless t.user.nil?
        emails << t.user.email if t.user.email.include?("@")
      end
    end

    emails.uniq.each do |email|
      ForumNotifier.send_new_forum_post_email(email, topic).deliver
    end
  end

end
