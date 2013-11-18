require 'spec_helper'

describe NflTeam do
  before(:each) do
    @team = build(:nfl_team)
  end

  it "Factory Generates Valid Model" do
    @team.should be_valid
  end
end