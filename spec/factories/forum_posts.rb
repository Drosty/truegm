# == Schema Information
#
# Table name: forum_posts
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  forum_topic_id :integer
#  post_body      :text
#  created_at     :datetime
#  updated_at     :datetime
#

FactoryGirl.define do
  factory :forum_post do
    user { FactoryGirl.create(:user) }
    forum_topic { FactoryGirl.create(:forum_topic) }
    post_body "Here is a post - blah blah blah"
  end
end
