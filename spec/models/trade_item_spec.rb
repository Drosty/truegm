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

require 'spec_helper'

describe TradeItem do
  before(:each) do
    @trade_item = build(:trade_item)
  end

  it "Factory Generates Valid Model" do
    @trade_item.should be_valid
  end
end
