# == Schema Information
#
# Table name: trade_votes
#
#  id         :integer          not null, primary key
#  trade_id   :integer
#  team_id    :integer
#  vote       :string
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :trade_vote do
    trade { FactoryGirl.create(:trade) }
    team { FactoryGirl.create(:team) }
    vote "MyString"
  end
end
