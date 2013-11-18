require 'spec_helper'

describe ForumTopic do
  before(:each) do
    @ft = build(:forum_topic)
  end

  it "Factory generates valid ForumTopic" do
    @ft.should be_valid
  end

  describe "Model is valid" do
    it "Has a name" do
      @ft.name = nil
      @ft.should_not be_valid
    end

    it "Has a description" do
      @ft.description = nil
      @ft.should_not be_valid
    end

    it "Belongs to a league" do
      @ft.league = nil
      @ft.should_not be_valid
    end
  end
  
  describe "non-admin user access" do
    it "can edit topics that it created" do
    
    end
    
    it "cannot edit topics that it didnt create" do
    
    end
    
    it "can view topics in leagues in" do
    
    end
    
    it "can not view topics in leagues not in" do
    
    end
    
    it "can create new topics in league in" do
    
    end
    
    it "cannot create new topics in leagues not in" do
    
    end
    
    it "cannot delete topics" do
    
    end
  end
  
  describe "admin user access" do
    it "can edit topics that it created" do
    
    end
    
    it "can edit topics that it didnt create" do
    
    end
    
    it "can view topics in leagues in" do
    
    end
    
    it "can view topics in leagues not in" do
    
    end
    
    it "can create new topics in league in" do
    
    end
    
    it "can create new topics in leagues not in" do
    
    end
    
    it "can delete topics" do
    
    end
  end
end
