require 'spec_helper'

describe TeamPolicy do

  describe "Admin User" do
    let(:user) do
      build(:user, :admin)
    end

    it "can show any team" do
      team = build(:team)
      assert TeamPolicy.new(user, team).show?
    end

    it "can edit any team" do
      team = build(:team)
      assert TeamPolicy.new(user, team).edit?
    end

    it "can update any team" do
      team = build(:team)
      assert TeamPolicy.new(user, team).update?
    end
  end

  describe "regular user" do
    let(:user) do
      build(:user)
    end

    it "can show teams that they are a user of" do
      team = build(:team)
      team.user = user
      assert TeamPolicy.new(user, team).show?
    end

    it "can show teams that they are in the same league as" do
      league = create(:league)
      team1 = create(:team, league: league)
      team2 = create(:team, league: league)
      team3 = create(:team)

      assert TeamPolicy.new(team1.user, team1).show?
      assert TeamPolicy.new(team1.user, team2).show?
      assert !TeamPolicy.new(team1.user, team3).show?

      assert TeamPolicy.new(team2.user, team1).show?
      assert TeamPolicy.new(team2.user, team2).show?
      assert !TeamPolicy.new(team2.user, team3).show?

      assert !TeamPolicy.new(team3.user, team1).show?
      assert !TeamPolicy.new(team3.user, team2).show?
      assert TeamPolicy.new(team3.user, team3).show?
    end

    it "can update and edit team that user is attached too" do
      team = build(:team)
      team.user = user
      assert TeamPolicy.new(user, team).update?
      assert TeamPolicy.new(user, team).edit?
    end

    it "cannot update or edit a team user is not attached too" do
      team = build(:team)
      user = build(:user)
      assert !TeamPolicy.new(user, team).update?
      assert !TeamPolicy.new(user, team).edit?
    end

  end

end
