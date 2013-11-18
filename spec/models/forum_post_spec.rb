require 'spec_helper'
require "cancan/matchers"

describe ForumPost do

  before (:each) do
    @fp = build(:forum_post)
  end

  it "Factory generates valid ForumPost" do
    @fp.should be_valid
  end

  it "Body body must be present" do
    @fp.post_body = nil
    @fp.should_not be_valid
  end

  it "must be part of a forum topic" do
    @fp.forum_topic = nil
    @fp.should_not be_valid
  end
  
  describe "non-admin user access" do
    before(:each) do
      @user = create(:user_with_one_team)
      @ability = Ability.new(@user)
    end

    it "can edit posts that it created" do
      assert @ability.can?(:update, create(:forum_post, :user => @user))
    end
    
    it "cannot edit posts that it didnt create" do
      assert @ability.cannot?(:update, create(:forum_post))
    end
    
    it "can create new posts in league in" do
      ft = create(:forum_topic, :league => @user.leagues.first)
      assert @ability.can?(:create, create(:forum_post, :forum_topic => ft))
    end
    
    it "cannot create new posts in leagues not in" do
      ft = create(:forum_topic)
      assert @ability.cannot?(:create, create(:forum_post, :forum_topic => ft))
    end
    
    it "cannot delete post" do
      assert @ability.cannot?(:delete, create(:forum_post))
    end
  end
  
  describe "admin user access" do
    before(:each) do
      @user = create(:user_with_one_team, :admin)
      @ability = Ability.new(@user)
    end

    it "can edit posts that it created" do
      assert @ability.can?(:update, create(:forum_post, :user => @user))
    end
    
    it "can edit posts that it didnt create" do
      assert @ability.can?(:update, create(:forum_post))
    end
      
    it "can create new posts in league in" do
      ft = create(:forum_topic, :league => @user.leagues.first)
      assert @ability.can?(:create, create(:forum_post, :forum_topic => ft))
    end
    
    it "can create new posts in leagues not in" do
      ft = create(:forum_topic)
      assert @ability.can?(:create, create(:forum_post, :forum_topic => ft))
    end
    
    it "can delete posts" do
      assert @ability.can?(:destroy, create(:forum_post))
    end
  end
end
