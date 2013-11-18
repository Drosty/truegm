# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trade do
    from_team { FactoryGirl.create(:team) }
    to_team { FactoryGirl.create(:team) }
  end
end
