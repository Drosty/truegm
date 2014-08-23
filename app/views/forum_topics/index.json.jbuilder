json.topics @forum_topics do |topic|
  json.(topic, :id, :name, :description)

  json.postCount pluralize(topic.forumposts_count, 'post')
  json.lastUpdate distance_of_time_in_words(Time.now, topic.updated_at)
end
