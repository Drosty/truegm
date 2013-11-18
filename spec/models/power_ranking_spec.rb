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
  
  describe "regular user access" do
    it "cannot edit" do
    
    end
    
    it "cannot delete" do
    
    end
    
    it "can view power rankings for own team in league" do
    
    end
    
    it "can view power ranking for teams in league" do
    
    end
    
    it "cannot view power ranking for teams in other leagues" do
    
    end
    
    it "cannot create" do
    
    end
  end
  
  describe "admin user access" do
    it "can edit" do
    
    end
    
    it "can delete" do
    
    end
    
    it "can create" do
    
    end
    
    it "can view all of them" do
    
    end
  end
  
  describe "commish user of a league" do
    it "can edit" do
    
    end
    
    it "can create" do
    
    end
  end
end
