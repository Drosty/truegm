require 'spec_helper'

describe NflPlayersHelper do

  describe "display team name" do

    it "is correct for a free agent player" do
      p = build(:nfl_player, :rb, :fa)
      display_team_name(p).should == "Free Agent"
    end

    it "is correct for a Player on a team" do
      p = build(:nfl_player, :wr)
      display_team_name(p).should == p.nfl_team_full_name
    end

    it "is an empty string for Defense" do
      p = build(:nfl_player, :def)
      display_team_name(p).should == ""
    end

  end
end
