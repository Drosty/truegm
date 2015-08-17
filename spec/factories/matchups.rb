# == Schema Information
#
# Table name: matchups
#
#  id           :integer          not null, primary key
#  year         :integer
#  week         :integer
#  home_team_id :integer
#  away_team_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

FactoryGirl.define do
  factory :matchup do
    year 1
    week 1
    home_team { FactoryGirl.create(:team) }
    away_team { FactoryGirl.create(:team) }
  end
end
