require 'spec_helper'

describe Stat do

  describe "stat calculation" do

    it "will calculate QB stats" do
      stat = build(:stat_qb_good)
      stat.total_points.should eq(27)

      stat = build(:stat_qb_bad)
      stat.total_points.should eq(4)
    end

    it "will calculate RB stats" do
      stat = build(:stat_rb_good)
      stat.total_points.should eq(39)

      stat = build(:stat_rb_bad)
      stat.total_points.should eq(3.2)
    end

    it "will calculate WR stats" do
      stat = build(:stat_wr_good)
      stat.total_points.should eq(39.5)

      stat = build(:stat_wr_bad)
      stat.total_points.should eq(0.3)
    end

  end

  describe "summary" do

  # Going to leave these - but need to update Stat Factory First
  #
  #  it "creates QB summary correctly" do
  #    stat = build(:stat_qb_good)
  #    stat.summary.should eq("Week 1 - 27.0 pts - 300 / 3 / 0")
  #  end

  #  it "creates RB summary correctly" do
  #    stat = build(:stat_rb_good)
  #    stat.summary.should eq("Week 1 - 39.5 pts - 130 yds / 2 td")
  #  end

  #  it "creates WR summary correctly" do
  #    stat = build(:stat_wr_good)
  #    stat.summary.should eq("Week 1 - 39.5 pts - 12rec / 137 yds")
  #  end

  end

end
