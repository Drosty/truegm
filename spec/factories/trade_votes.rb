FactoryGirl.define do
  factory :trade_vote do
    trade { FactoryGirl.create(:trade) }
    team { FactoryGirl.create(:team) }
    vote "MyString"
  end
end
