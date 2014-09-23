json.page @page
json.perPage @perPage

json.activities @activities do |activity|

  case activity.trackable_type
  when "ForumPost"
    json.item_text activity.trackable.forum_topic.name
    json.item_id activity.trackable.forum_topic.id
    json.item_url "topics"
    json.sub_title ""
    json.sub_title_url ""
    json.sub_title_id ""
  when "ForumTopic"
    json.item_text activity.trackable.name
    json.item_id activity.trackable.id
    json.item_url "topics"
    json.sub_title ""
    json.sub_title_url ""
    json.sub_title_id ""
  when "Team"
    json.item_text activity.trackable.name
    json.item_id activity.trackable.id
    json.item_url "team"
    json.sub_title "Player: #{activity.recipient.full_name}"
    json.sub_title_url "player"
    json.sub_title_id activity.recipient.id
  else
    json.item_text ""
    json.item_id ""
    json.item_url ""
    json.sub_title ""
    json.sub_title_url ""
    json.sub_title_id ""
  end

  json.header_text activity.text
  json.user_name activity.owner.name
  json.user_id activity.owner.id
  json.date activity.created_at.in_time_zone("Central Time (US & Canada)").to_s
end
