require 'spec_helper'

describe Matchup do
  before(:each) do
    @matchup = build(:matchup)
  end

  it "Factory Generates Valid Model" do
    @matchup.should be_valid
  end
  
  it "should have a home team" do
  
  end
  
  it "should have an away team" do
  
  end
  
  it 'home and away team are in the same league' do
  
  end
  
  it "should have a week" do
  
  end
  
  it "should have a year" do
  
  end
  
  it "cant have a home or away team with more than one matchup a week" do
  
  end
end
