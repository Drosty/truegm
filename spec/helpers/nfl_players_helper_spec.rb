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

  describe "home_or_away_code" do
    let(:player) { build(:nfl_player) }
    let(:team) { player.nfl_team }

    it "will return correct value for home" do
      matchup = create(:nfl_matchup, week: 1, year: 2014)
      team.home_matchups << matchup

      home_or_away_code(player, 1, 2014).should == "vs"
    end

    it "will return correct value for away" do
      matchup = create(:nfl_matchup, week: 1, year: 2014)
      team.away_matchups << matchup

      home_or_away_code(player, 1, 2014).should == "at"
    end

    it "will return bye if matchup not found" do
      home_or_away_code(player, 1, 2014).should == "BYE"
    end
  end

  describe "opponent_code" do
    let(:player) { build(:nfl_player) }
    let(:team) { player.nfl_team }

    it "will return correct value for home" do
      matchup = create(:nfl_matchup, week: 1, year: 2014)
      team.home_matchups << matchup

      opponent_code(player, 1, 2014).should == "AWAY"
    end

    it "will return correct value for away" do
      matchup = create(:nfl_matchup, week: 1, year: 2014)
      team.away_matchups << matchup

      opponent_code(player, 1, 2014).should == "HOME"
    end

    it "will return bye if matchup not found" do
      opponent_code(player, 1, 2014).should == ""
    end
  end

  describe "matchup_formatted_date" do
    let(:player) { build(:nfl_player) }
    let(:team) { player.nfl_team }

    it "will return correct value for home" do
      matchup = create(:nfl_matchup, week: 1, year: 2014)
      team.home_matchups << matchup

      matchup_formatted_date(player, 1, 2014).should == "Fri, 10:25am"
    end

    it "will return correct value for away" do
      matchup = create(:nfl_matchup, week: 1, year: 2014)
      team.away_matchups << matchup

      matchup_formatted_date(player, 1, 2014).should == "Fri, 10:25am"
    end

    it "will return bye if matchup not found" do
      matchup_formatted_date(player, 1, 2014).should == ""
    end
  end

  describe "matchup_tv_station" do
    it "returns empty string every time" do
      matchup_tv_station(nil, nil, nil).should == ""
      matchup_tv_station(123, 1, 2014).should == ""
    end
  end
end
