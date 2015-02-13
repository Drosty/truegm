FactoryGirl.define do
  factory :forum_post do
    user { FactoryGirl.create(:user) }
    forum_topic { FactoryGirl.create(:forum_topic) }
    post_body "Here is a post - blah blah blah"
  end
end
