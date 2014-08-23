json.success @success

json.topic do
  json.id @forum_topic.id
end if !@forum_topic.nil? && @success
