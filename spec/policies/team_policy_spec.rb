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

    end

    it "cannot show teams that are in leagues they are not part of" do

    end

  end

end
