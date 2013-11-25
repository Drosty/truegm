require 'spec_helper'

describe Trade do
  before(:each) do
    @trade = build(:trade)
  end

  it "Factory Generates Valid Model" do
    @trade.should be_valid
  end
end
