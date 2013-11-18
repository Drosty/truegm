FactoryGirl.define do
  factory :forum_topic do
    league { FactoryGirl.create(:league) }
    name "MyString"
    description "MyText"
  end
end
