FactoryGirl.define do
  factory :power_ranking do
    team { FactoryGirl.create(:team) }
    description "MyText"
    rank 1
    week 1
    year 1
  end
end
