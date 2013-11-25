require 'spec_helper'

describe PowerRanking do
  before(:each) do
    @ranking = build(:power_ranking)
  end

  it "Factory generates valid ForumPost" do
    @ranking.should be_valid
  end

  it "Must have a description" do
    @ranking.description = nil
    @ranking.should_not be_valid
  end
  
  it "Must have a Team" do
  
  end
  
  it "must have a week set" do
  
  end
end
