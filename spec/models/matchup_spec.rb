require 'spec_helper'

describe Matchup do
  before(:each) do
    @matchup = build(:matchup)
  end

  it "Factory Generates Valid Model" do
    @matchup.should be_valid
  end
end
