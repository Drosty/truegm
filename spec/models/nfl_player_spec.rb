require 'spec_helper'

describe NflPlayer do
  before(:each) do
    @player = build(:nfl_player)
  end

  describe "basic methods on Player" do
    it "Factory Generates Valid Model" do
      @player.should be_valid
    end

    it "will return field if it is available" do
      p = build(:nfl_player, full_name: "test fullname")
      p.full_name.should eq("test fullname")
    end

    it "will return true to free agent when player is" do
      @player.free_agent?(1).should eq(true)
    end

    it "will return false to free agent when player is on team" do
      team = create(:team)
      team.nfl_players << @player
      @player.free_agent?(team.league_id).should eq(false)
    end

    it "will return FA to fantasy_team_name when player is FA" do
      @player.fantasy_team_name(1).should eq("FA")
    end

    it "will return Team Name when player is on a team in the league" do
      team = create(:team)
      team.nfl_players << @player
      @player.fantasy_team_name(team.league_id).should eq(team.name)
    end
  end

  describe "creating hashes of the players" do
    it "will create same hash with same string except whitespace" do
      first = NflPlayer.generate_hash(" Henry Smith ", "WR ", "ARI ")
      second = NflPlayer.generate_hash("Henry Smith", " WR", " ARI")
      assert_equal first, second
    end

    it "will create same hash with same string except Special chars" do
      first = NflPlayer.generate_hash(" Henry.Smith$!", "WR**", ".,:ARI;")
      second = NflPlayer.generate_hash("+{|`~Henry Smith#", " WR()", "!@ARI-_'")
      assert_equal first, second
    end

    it "will create same hash with same string except case" do
      first = NflPlayer.generate_hash(" Henry SMITH ", "WR ", "ARI ")
      second = NflPlayer.generate_hash("Henry Smith", " Wr", " Ari")
      assert_equal first, second
    end
  end

end
