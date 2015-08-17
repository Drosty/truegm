# == Schema Information
#
# Table name: trade_items
#
#  id         :integer          not null, primary key
#  trade_id   :integer
#  item_id    :integer
#  item_type  :string
#  team       :integer
#  value      :string
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :trade_item do
    trade { FactoryGirl.create(:trade) }
    item_id 1
    item_type "MyString"
    team 1
    value "MyString"
  end
end
