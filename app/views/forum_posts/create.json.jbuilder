json.success @success

json.post do
  json.id @forum_post.id
  json.topic_id @forum_post.forum_topic.id
end if !@forum_post.nil? && @success
