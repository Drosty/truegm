FactoryGirl.define do
  factory :external_link do
    user { FactoryGirl.create(:user) }
    name "MyString"
    description "MyText"
    url "MyString"
  end
end
