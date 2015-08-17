# == Schema Information
#
# Table name: trades
#
#  id           :integer          not null, primary key
#  from_team_id :integer
#  to_team_id   :integer
#  created_at   :datetime
#  updated_at   :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :trade do
    from_team { FactoryGirl.create(:team) }
    to_team { FactoryGirl.create(:team) }
  end
end
