unless @forum_topic.nil?
  json.(@forum_topic, :id, :name, :description)

  json.posts @forum_topic.forum_posts do |post|
    json.(post, :id, :post_body)

    json.timeAgo distance_of_time_in_words(Time.now, post.created_at)
    json.user post.user, :id, :name unless post.user.nil?
  end
end
