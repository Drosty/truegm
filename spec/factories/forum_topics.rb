FactoryGirl.define do
  factory :forum_topic do
    user { FactoryGirl.create(:user) }
    league { FactoryGirl.create(:league) }
    name "Forum Topic"
    description "Topic about some really awesome thing"
    forumposts_count 0
  end
end
