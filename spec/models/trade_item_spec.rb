require 'spec_helper'

describe TradeItem do
  before(:each) do
    @trade_item = build(:trade_item)
  end

  it "Factory Generates Valid Model" do
    @trade_item.should be_valid
  end
  
  it "can be of type money, player or pick" do
  
  end
end
