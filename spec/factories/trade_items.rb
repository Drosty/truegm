FactoryGirl.define do
  factory :trade_item do
    trade { FactoryGirl.create(:trade) }
    item_id 1
    item_type "MyString"
    team 1
    value "MyString"
  end
end
