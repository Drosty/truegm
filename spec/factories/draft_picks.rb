# == Schema Information
#
# Table name: draft_picks
#
#  id               :integer          not null, primary key
#  team_id          :integer
#  year             :integer
#  round            :integer
#  position         :integer
#  original_team_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

FactoryGirl.define do
  factory :draft_pick do
    original_team { FactoryGirl.create(:team) }
    current_team { FactoryGirl.create(:team) }
    year 1
    round 1
    position 1
  end
end
