unless @forum_topic.nil?
  json.(@forum_topic, :id, :name, :description)

  json.posts @forum_topic.forum_posts do |post|
    json.(post, :id, :post_body)

    json.timeAgo distance_of_time_in_words(Time.now, post.created_at)
    json.user post.user, :id, :name unless post.user.nil?
  end

  json.league do
    json.(@current_league, :id, :name, :description, :tagline)

    json.teams @current_league.teams do |team|
      json.(team, :id, :name)
      json.salary format_as_money(team.total_salary)

      json.user team.user, :id, :name unless team.user.nil?
      json.user nil if team.user.nil?
    end

  end
end
