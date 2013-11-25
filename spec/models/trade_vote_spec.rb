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
end
