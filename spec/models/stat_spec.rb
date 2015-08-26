# == Schema Information
#
# Table name: stats
#
#  id                              :integer          not null, primary key
#  nfl_player_id                   :integer
#  passing_yards                   :integer
#  passing_touchdowns              :integer
#  rushing_yards                   :integer
#  rushing_touchdowns              :integer
#  receptions                      :integer
#  receiving_yards                 :integer
#  receiving_touchdowns            :integer
#  fumbles_lost                    :integer
#  year                            :integer
#  week                            :integer
#  tfl                             :integer
#  qbhits                          :integer
#  defensive_interceptions         :integer
#  fumbles_recovered               :integer
#  safties                         :integer
#  defensive_tds                   :integer
#  return_tds                      :integer
#  points_allowed                  :integer
#  opponent                        :string
#  final_score                     :string
#  played                          :boolean
#  started                         :boolean
#  passing_completions             :integer
#  passing_attempts                :integer
#  passing_percentage              :float
#  qb_rating                       :float
#  rushing_attempts                :integer
#  rushing_average                 :float
#  long_run                        :integer
#  receiving_long                  :integer
#  passing_sacks                   :integer
#  defensive_sacks                 :integer
#  passing_interceptions           :integer
#  receiving_targets               :integer
#  two_point_conversion_receptions :integer
#  two_point_conversion_runs       :integer
#

require 'spec_helper'

describe Stat do

  describe "stat calculation" do

    it "will calculate QB stats" do
      league = build(:league_with_stats)
      stat = build(:stat_qb_good)
      stat.total_points(league).should eq(27)

      stat = build(:stat_qb_bad)
      stat.total_points(league).should eq(4)
    end

    it "will calculate RB stats" do
      league = build(:league_with_stats)
      stat = build(:stat_rb_good)
      stat.total_points(league).should eq(39)

      stat = build(:stat_rb_bad)
      stat.total_points(league).should eq(3.2)
    end

    it "will calculate WR stats" do
      league = build(:league_with_stats)
      stat = build(:stat_wr_good)
      stat.total_points(league).should eq(39.5)

      stat = build(:stat_wr_bad)
      stat.total_points(league).should eq(0.3)
    end

  end

  describe "summary" do
    # Going to leave these - but need to update Stat Factory First
    it "creates QB summary correctly" do
      stat = build(:stat_qb_good)
      stat.summary.should eq("300 yards / 3 TDs / 0 INTs")
    end

    it "creates RB summary correctly" do
      stat = build(:stat_rb_good)
      stat.summary.should eq("130 yards / 2 TDs")
    end

    it "creates WR summary correctly" do
      stat = build(:stat_wr_good)
      stat.summary.should eq("12 rec / 137 yards / 2 TDs")
    end
  end

  describe "Position Specific Stats" do
    it "returns quarterback stats" do
      build(:stat_qb_good).position_specific_stats.should == {:passing_yards=>300, :passing_touchdowns=>3, :interceptions=>0, :rushing_yards=>0, :rushing_touchdown=>0, :fumbles_lost=>0}
    end

    it "returns runningback stats" do
      build(:stat_rb_good).position_specific_stats.should == {:rushing_yards=>130, :rushing_touchdown=>2, :receptions=>4, :receiving_yards=>40, :receiving_touchdowns=>1, :fumbles_lost=>0}
    end

    it "returns wide receiver stats" do
      build(:stat_wr_good).position_specific_stats.should == {:receptions=>12, :receiving_yards=>137, :receiving_touchdowns=>2, :rushing_yards=>18, :rushing_touchdown=>0, :fumbles_lost=>0}
    end

    it "returns tight end stats" do
      build(:stat_te_bad).position_specific_stats.should == {:receptions=>2, :receiving_yards=>7, :receiving_touchdowns=>0, :rushing_yards=>-4, :rushing_touchdown=>0, :fumbles_lost=>1}
    end

    it "returns defensive stats" do
      build(:defense_stat).position_specific_stats.should == {:points_allowed=>11, :sacks=>nil, :interceptions=>4, :fumbles_recovered=>3, :defensive_touchdowns=>1, :returned_touchdowns=>nil, :safties=>2}
    end
  end

end
