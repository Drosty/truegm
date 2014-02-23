require 'spec_helper'

describe NflPlayer do
  before(:each) do
    @player = build(:nfl_player)
  end

  it "Factory Generates Valid Model" do
    @player.should be_valid
  end

  it "will return first+last name if full name nil" do
    p = build(:nfl_player, full_name: nil)
    p.full_name.should eq(p.first_name + ' ' + p.last_name)
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
