FactoryGirl.define do
  factory :matchup do
    year 1
    week 1
    home_team { FactoryGirl.create(:team) }
    away_team { FactoryGirl.create(:team) }
  end
end
