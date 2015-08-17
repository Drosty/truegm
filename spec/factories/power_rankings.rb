# == Schema Information
#
# Table name: power_rankings
#
#  id          :integer          not null, primary key
#  team_id     :integer
#  description :text
#  rank        :integer
#  week        :integer
#  year        :integer
#  created_at  :datetime
#  updated_at  :datetime
#

FactoryGirl.define do
  factory :power_ranking do
    team { FactoryGirl.create(:team) }
    description "MyText"
    rank 1
    week 1
    year 1
  end
end
