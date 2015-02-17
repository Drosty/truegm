require 'spec_helper'

describe NflMatchup do

  it "will return correct at string when away team" do
    team = build(:nfl_team)
    matchup = build(:nfl_matchup, away_team: team)
    matchup.home_or_away(team).should == "at"
  end

  it "will return correct vs string when home team" do
    team = build(:nfl_team)
    matchup = build(:nfl_matchup, home_team: team)
    matchup.home_or_away(team).should == "vs"
  end

  it "will return correct fa string when not home or away" do
    matchup = build(:nfl_matchup)
    matchup.home_or_away(nil).should == "BYE"
  end

  it "will return correct at string when away team" do
    team = build(:nfl_team, code: "abc")
    matchup = build(:nfl_matchup, away_team: team)
    matchup.opponent_code(team).should == "HOME"
  end

  it "will return correct vs string when home team" do
    team = build(:nfl_team, code: "abc")
    matchup = build(:nfl_matchup, home_team: team)
    matchup.opponent_code(team).should == "AWAY"
  end

  it "will return correct fa string when not home or away" do
    matchup = build(:nfl_matchup)
    matchup.opponent_code(nil).should == "BYE"
  end

end
