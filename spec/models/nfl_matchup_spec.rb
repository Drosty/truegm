# == Schema Information
#
# Table name: nfl_matchups
#
#  id                     :integer          not null, primary key
#  import_game_id         :integer
#  week                   :integer
#  year                   :integer
#  game_date              :datetime
#  away_team_id           :integer
#  home_team_id           :integer
#  tv_station             :string
#  created_at             :datetime
#  updated_at             :datetime
#  point_spread           :float
#  over_under             :float
#  game_key               :string
#  away_score             :integer
#  home_score             :integer
#  quarter                :integer
#  time_remaining         :string           default("0:00")
#  possession             :string
#  down                   :integer
#  distance               :integer
#  yard_line              :integer
#  yard_line_territory    :string
#  red_zone               :boolean          default(FALSE)
#  away_score_quarter1    :integer
#  away_score_quarter2    :integer
#  away_score_quarter3    :integer
#  away_score_quarter4    :integer
#  away_score_overtime    :integer
#  home_score_quarter1    :integer
#  home_score_quarter2    :integer
#  home_score_quarter3    :integer
#  home_score_quarter4    :integer
#  home_score_overtime    :integer
#  has_started            :boolean          default(FALSE)
#  is_in_progress         :boolean          default(FALSE)
#  is_over                :boolean          default(FALSE)
#  has1st_quarter_started :boolean          default(FALSE)
#  has2nd_quarter_started :boolean          default(FALSE)
#  has3rd_quarter_started :boolean          default(FALSE)
#  has4th_quarter_started :boolean          default(FALSE)
#  is_overtime            :boolean          default(FALSE)
#  down_and_distance      :string           default("1st and 10")
#  quarter_description    :string
#  last_updated           :datetime
#

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
