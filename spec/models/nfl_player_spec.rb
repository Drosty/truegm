# == Schema Information
#
# Table name: nfl_players
#
#  id              :integer          not null, primary key
#  nfl_team_id     :integer
#  first_name      :string
#  last_name       :string
#  position        :string
#  salary          :integer
#  created_at      :datetime
#  updated_at      :datetime
#  spotrac_url     :string
#  full_name       :string
#  jersey          :string
#  height          :string
#  weight          :string
#  dob             :datetime
#  college         :string
#  active          :boolean
#  current_status  :string
#  depth_order     :integer
#  experience      :integer
#  photo_url       :string
#  fantasy_data_id :integer
#

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

  describe "position scope" do
    before(:each) do
      team = create(:team)
      @league = team.league
      teams = [team]

      create(:nfl_player, :qb, teams: teams, salary: 0, last_name: "test")
      create(:nfl_player, :rb, teams: teams, salary: 123)
      create(:nfl_player, :rb, salary: nil)
      create(:nfl_player, :wr, salary: nil, last_name: "testing")
      create(:nfl_player, :wr, salary: 123123)
      create(:nfl_player, :wr, salary: nil, last_name: "frtesting")
      create(:nfl_player, :te, teams: teams, salary: nil)
      create(:nfl_player, :te, salary: 93938)
      create(:nfl_player, :te, salary: 0, last_name: "nothing")
      create(:nfl_player, :te, salary: 1234)
    end

    it "will return last name search correctly" do
      NflPlayer.search("test").count.should == 3
      NflPlayer.search("  fRt").count.should == 1
      NflPlayer.search(nil).count.should == 10
    end

    it "will get free agents by status call" do
      NflPlayer.by_status("free agent", @league).count.should == 7
      NflPlayer.by_status("owned", @league).count.should == 3
      NflPlayer.by_status("all", @league).count.should == 10
    end

    it "with_salary returns correctly" do
      NflPlayer.with_salary.count.should == 4
    end

    it "returns all for all" do
      NflPlayer.positions(Position::ALL_STRING).count.should == 10
    end

    it "return only qbs" do
      NflPlayer.positions(Position::QUARTERBACK).count.should == 1
    end

    it "return only rbs" do
      NflPlayer.positions(Position::RUNNINGBACK).count.should == 2
    end

    it "return only wrs" do
      NflPlayer.positions(Position::WIDERECEIVER).count.should == 3
    end

    it "return only tes" do
      NflPlayer.positions(Position::TIGHTEND).count.should == 4
    end

    it "return flex players" do
      NflPlayer.positions("flex").count.should == 9
      NflPlayer.positions("rb/wr/te").count.should == 9
    end
  end

  describe "fuzzy name matching for spotrac" do
    let(:team) { create(:nfl_team) }

    it "will find a perfect match" do
      player = create(:nfl_player, :qb, full_name: "Ryan Smith", nfl_team: team)
      NflPlayer.fuzzy_find_by_spotrac("Ryan Smith", "qb", team).should == player
    end

    it "will match with a jr in the name" do
      player = create(:nfl_player, :qb, full_name: "Ryan Smith", nfl_team: team)
      NflPlayer.fuzzy_find_by_spotrac("Ryan Smith JR", "qb", team).should == player
    end

    it "will match with a iii in the name" do
      player = create(:nfl_player, :qb, full_name: "Ryan Smith", nfl_team: team)
      NflPlayer.fuzzy_find_by_spotrac("Ryan Smith III", "qb", team).should == player
    end

    it "will match with Rob vs Robert" do
      player = create(:nfl_player, :qb, full_name: "Robert Smith", nfl_team: team)
      NflPlayer.fuzzy_find_by_spotrac("Rob Smith", "qb", team).should == player
    end

    it "will match with Joshua vs Josh" do
      player = create(:nfl_player, :qb, full_name: "Josh Smith", nfl_team: team)
      NflPlayer.fuzzy_find_by_spotrac("Joshua Smith", "qb", team).should == player
    end

    it "will match with Fozzy vs Foswhitt" do
      player = create(:nfl_player, :qb, full_name: "Foswhitt Smith", nfl_team: team)
      NflPlayer.fuzzy_find_by_spotrac("Fozzy Smith", "qb", team).should == player
    end
  end

  describe "team matchup" do
    it "will return the correct matchup" do
      team = @player.nfl_team
      matchup = create(:nfl_matchup, week: 1, year: 2014)
      team.home_matchups << matchup

      @player.week_nfl_matchup(1, 2014).should == matchup
    end

    it "will return nil if not found" do
      team = @player.nfl_team
      matchup = create(:nfl_matchup, week: 1, year: 2014)
      team.home_matchups << matchup

      @player.week_nfl_matchup(12, 2014).should == nil
    end
  end

end
