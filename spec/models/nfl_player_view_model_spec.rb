require 'spec_helper'

describe NflPlayerViewModel do

  let(:player) { build(:nfl_player) }

  describe "no stats in View Model" do
    before(:each) do
      @player_stat_vm = NflPlayerStatViewModel.new()
    end

    it "will not have any years" do
      @player_stat_vm.stats_by_year.should == {}
    end
  end

  describe "with one stats in View Model" do
    before(:each) do
      @stat = build(:stat_qb_good, year: 2014)
      @player_stat_vm = NflPlayerStatViewModel.new([@stat])
    end

    it "will return array with stat in it" do
      @player_stat_vm.stats_by_year.should == {2014 => [@stat]}
    end
  end

  describe "with multiple stats in View Model" do
    before(:each) do
      @stat_1 = build(:stat_qb_good, {year: 2014, week: 1})
      @stat_2 = build(:stat_qb_bad, year: 2014, week: 2)
      @stat_3 = build(:stat_qb_good, year: 2013, week: 4)
      @stat_4 = build(:stat_qb_bad, year: 2013, week: 3)

      stats = [@stat_1, @stat_2, @stat_3, @stat_4]
      @player_stat_vm = NflPlayerStatViewModel.new(stats)
    end

    it "will return array with stat in it" do
      hash_to_be = {2014 => [@stat_1, @stat_2], 2013 => [@stat_4, @stat_3]}
      @player_stat_vm.stats_by_year.should == hash_to_be
    end
  end

end