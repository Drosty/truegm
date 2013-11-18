FactoryGirl.define do
  factory :draft_pick do
    original_team { FactoryGirl.create(:team) }
    current_team { FactoryGirl.create(:team) }
    year 1
    round 1
    position 1
    original_team_id 1
  end
end
