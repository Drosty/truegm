require 'spec_helper'
require 'cancan/matchers'

describe TradeVote do
  before(:each) do
    @trade_vote_obj = build(:trade_vote)
  end

  it "Factory Generates Valid Model" do
    @trade_vote_obj.should be_valid
  end

  describe "Has valid relations" do
    it "Needs to have a trade" do
      @trade_vote_obj.trade = nil
      @trade_vote_obj.should_not be_valid
    end

    it "Needs to have a team" do
      @trade_vote_obj.team = nil
      @trade_vote_obj.should_not be_valid
    end
    
    it "team and trade have to be in same league" do
    
    end
  end

  describe "can toggle" do
    it "Can toggle from up to down" do
      @trade_vote_obj.vote = "up"
      @trade_vote_obj.toggle_vote
      @trade_vote_obj.vote.should == "down"
    end

    it "Can toggle from down to up" do
      @trade_vote_obj.vote = "down"
      @trade_vote_obj.toggle_vote
      @trade_vote_obj.vote.should == "up"
    end
  end

  describe 'access' do
    before(:each) do
      @user = create(:user_with_one_team)
      @ability = Ability.new(@user)
    end

    it 'can vote for trade in league' do
      trade = create(:trade, :from_team => @user.leagues.first.teams.first, :to_team => @user.leagues.first.teams.fetch(1, nil))
      assert @ability.can?(:create, create(:trade_vote, :trade => trade)) 
    end
    
    it 'cannot vote for trade in other league' do
    
    end
    
    it 'cannot have more than one vote per trade' do
    
    end
    
    it 'can change vote for trade' do
    
    end
    
    it 'can only change vote 2 times per trade' do
    
    end
  end
end
