require 'spec_helper'

describe DraftPick do
  before(:each) do
    @pick = build(:draft_pick)
  end
  
  describe "model is valid" do
    it "Factory Generates Valid Model" do
      @pick.should be_valid
    end
    
    it "should have a year" do
      @pick.year = nil
      @pick.should_not be_valid
    end
    
    it "should have a round" do
      @pick.round = nil
      @pick.should_not be_valid
    end
    
    it "should have a original team" do
      @pick.original_team = nil
      @pick.should_not be_valid
    end
    
    it "should have a current team" do
      
    end
    
    it "current and original team in same league" do
    
    end
    
    it "current and original team cant be in different leagues" do
    
    end
  end
end
