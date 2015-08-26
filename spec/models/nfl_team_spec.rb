# == Schema Information
#
# Table name: nfl_teams
#
#  id          :integer          not null, primary key
#  created_at  :datetime
#  updated_at  :datetime
#  spotrac_url :string
#  code        :string
#  full_name   :string
#  short_name  :string
#  bye_week    :integer
#

require 'spec_helper'

describe NflTeam do
  let(:nfl_team) { create(:nfl_team) }

  it "Factory Generates Valid Model" do
    nfl_team.should be_valid
  end

  describe "getting matchups" do
    it "will return all matchups where home or away" do
      nfl_team.home_matchups << create(:nfl_matchup, week: 1, year: 2014)
      nfl_team.home_matchups << create(:nfl_matchup, week: 2, year: 2014)
      nfl_team.away_matchups << create(:nfl_matchup, week: 3, year: 2014)
      nfl_team.away_matchups << create(:nfl_matchup, week: 4, year: 2014)

      nfl_team.matchups(2014).count.should == 4
    end

    it "will return matchups for the year passed into the list" do
      nfl_team.home_matchups << create(:nfl_matchup, week: 1, year: 2014)
      nfl_team.home_matchups << create(:nfl_matchup, week: 2, year: 2013)
      nfl_team.away_matchups << create(:nfl_matchup, week: 3, year: 2014)
      nfl_team.away_matchups << create(:nfl_matchup, week: 4, year: 2014)

      nfl_team.matchups(2014).count.should == 3
      nfl_team.matchups(2013).count.should == 1
    end

    it "will not return any if the year doesn't match any of them" do
      nfl_team.away_matchups << create(:nfl_matchup, week: 4, year: 2014)

      nfl_team.matchups(2014).count.should == 1
      nfl_team.matchups(2016).count.should == 0
    end

    it "will raise an exception if null is passed into the method for year" do
      expect { nfl_team.matchups(nil) }.to raise_error
    end
  end

  describe "weekly nfl matchups call" do
    it "will raise an exception if null is passed in as either parameter" do
      expect { nfl_team.week_nfl_matchup(nil, 4) }.to raise_error
      expect { nfl_team.week_nfl_matchup(5, nil) }.to raise_error
      expect { nfl_team.week_nfl_matchup(nil, nil) }.to raise_error
    end

    it "will return matchups for the year passed into the list" do
      matchup = create(:nfl_matchup, week: 1, year: 2014)
      nfl_team.home_matchups << matchup

      nfl_team.week_nfl_matchup(1, 2014).should == matchup
    end

    it "will return nil if matchup not found" do
      nfl_team.home_matchups << create(:nfl_matchup, week: 1, year: 2014)

      nfl_team.week_nfl_matchup(2, 2014).should == nil
    end
  end

end
