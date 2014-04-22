require 'spec_helper'

describe LeaguePolicy do

  describe "admin user" do
    let(:user) do
      build(:user, :admin)
    end

    it "can access index page" do
      assert LeaguePolicy.new(user, nil).index?
    end

    it "can access show page" do
      league = build(:league)
      assert LeaguePolicy.new(user, league).show?
    end
  end

  describe "non-admin user" do
    let(:user) do
      build(:user)
    end

    it "can access the index page" do
      assert LeaguePolicy.new(user, nil).index?
    end

    it "can access the show page of a league it is a part of" do
      league = build(:league)
      team = build(:team)
      team.league = league
      user.teams = [team]
      assert LeaguePolicy.new(user, league).show?
    end

    it "can not access the show page of league not a part of" do
      league = build(:league)
      assert !LeaguePolicy.new(user, league).show?
    end
  end

  describe "no user" do
    it "can not access the index page" do
      assert !LeaguePolicy.new(nil, nil).index?
    end

    it "can not access the show page" do
      league = build(:league)
      assert !LeaguePolicy.new(nil, nil).index?
    end
  end

end
