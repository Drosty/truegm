require 'spec_helper'

describe NflPlayer do
  before(:each) do
    @player = build(:nfl_player)
  end

  it "Factory Generates Valid Model" do
    @player.should be_valid
  end

  it "will return first+last name if full name nil" do
    @player = build(:nfl_player, full_name: nil)
    @player.full_name.should eq(@player.first_name + ' ' + @player.last_name)
  end

  it "will return field if it is available" do
    @player = build(:nfl_player, full_name: "test fullname")
    @player.full_name.should eq("test fullname")
  end

end
