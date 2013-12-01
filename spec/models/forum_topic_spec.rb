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

    it "Has to have a user" do
      @ft.user = nil
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
    before(:each) do
      @user = create(:user_with_one_team)
      @ability = Ability.new(@user)
    end

    it "can edit topics that it created" do
      assert @ability.can?(:update, create(:forum_topic, :user => @user))
    end
    
    it "cannot edit topics that it didnt create" do
      assert @ability.cannot?(:update, create(:forum_topic))
    end
    
    it "can create new topics in league in" do
      assert @ability.can?(:create, create(:forum_topic, :league => @user.leagues.first))
    end
    
    it "cannot create new topics in leagues not in" do 
      assert @ability.cannot?(:create, create(:forum_topic, :league => create(:league)))
    end
    
    it "cannot delete topic" do
      assert @ability.cannot?(:destroy, create(:forum_topic))
    end
  end
  
  describe "admin user access" do
    before(:each) do
      @user = create(:user_with_one_team, :admin)
      @ability = Ability.new(@user)
    end

    it "can edit topic" do
      assert @ability.can?(:update, :forum_topic)
    end
    
    it "can create new topics" do
      assert @ability.can?(:create, :forum_topic)
    end
    
    it "can delete topics" do
      assert @ability.can?(:destroy, :forum_topic) 
    end
  end
end
