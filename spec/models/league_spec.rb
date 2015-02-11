require 'spec_helper'

describe League do
  before(:each) do
    @league = build(:league)
  end

  it "Factory generates valid League" do
    @league.should be_valid
  end

  describe "League model is valid" do
    it "Should have a name" do
      @league.name = nil
      @league.should_not be_valid
    end

    it "Name has to be 5 characters at least" do
      @league.name = "1234"
      @league.should_not be_valid
    end

    it "Name can't be more than 20 characters" do
      @league.name = "123456789012345678901"
      @league.should_not be_valid
    end

    it "Should have a tagline" do
      @league.tagline = nil
      @league.should_not be_valid
    end
  end

  describe "methods that require teams set" do
    before(:each) do
      teams = [create(:team), create(:team), create(:team)]
      teams.each_with_index {|team, index| team.id = index+1 }
      @league.teams << teams
    end

    it "will return correct team ids" do
      @league.get_team_ids.should == [1,2,3]
    end
  end

end
