json.topics @forum_topics do |topic|
  json.(topic, :id, :name, :description)

  json.postCount pluralize(topic.forumposts_count, 'post')
  json.lastUpdate distance_of_time_in_words(Time.now, topic.updated_at)
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
