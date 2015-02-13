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

end
