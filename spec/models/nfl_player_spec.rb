require 'spec_helper'

describe NflPlayer do
  before(:each) do
    @player = build(:nfl_player)
  end

  it "Factory Generates Valid Model" do
    @player.should be_valid
  end
end
