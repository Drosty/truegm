require 'spec_helper'

describe NflPlayerViewModel do

  describe "no stats in View Model" do
    before(:each) do
      @player_stat_vm = NflPlayerViewModel.new()
    end

    it "will not have any years" do
      @player_stat_vm.stats_by_year.should == {}
    end

    it "will not have a player" do
      @player_stat_vm.player.should == nil
    end
  end

  describe "with one stats in View Model" do
    before(:each) do
      @stat = build(:stat_qb_good, year: 2014)
      @player_stat_vm = NflPlayerViewModel.new(nil, [@stat])
    end

    it "will return array with stat in it" do
      @player_stat_vm.stats_by_year.should == {2014 => [@stat]}
    end
  end

  describe "with multiple stats in View Model" do
    before(:each) do
      @stat_1 = build(:stat_qb_good, year: 2014, week: 1)
      @stat_2 = build(:stat_qb_bad, year: 2014, week: 2)
      @stat_3 = build(:stat_qb_good, year: 2013, week: 4)
      @stat_4 = build(:stat_qb_bad, year: 2013, week: 3)

      stats = [@stat_1, @stat_2, @stat_3, @stat_4]
      @player_stat_vm = NflPlayerViewModel.new(nil, stats)
    end

    it "will return array with stat in it" do
      hash_to_be = {2014 => [@stat_1, @stat_2], 2013 => [@stat_4, @stat_3]}
      @player_stat_vm.stats_by_year.should == hash_to_be
    end
  end

  describe "player model in view model" do
    it "will return the player position" do
      model = NflPlayerViewModel.new(build(:nfl_player, :wr))
      model.player_position.should == Position::WIDERECEIVER
    end

    it "will return the player model" do
      player = build(:nfl_player)
      model = NflPlayerViewModel.new(player, nil)
      model.player.should == player
    end
  end

  describe "Stat Category Headers" do
    it "will be set correctly for a QB" do
      player = build(:nfl_player, :qb)
      model = NflPlayerViewModel.new(player, nil)
      model.stat_catagories_headers.should == ["Passing", "Rushing"]
    end

    it "will be set correctly for a RB" do
      player = build(:nfl_player, :rb)
      model = NflPlayerViewModel.new(player, nil)
      model.stat_catagories_headers.should == ["Rushing", "Receiving"]
    end

    it "will be set correctly for a WR" do
      player = build(:nfl_player, :wr)
      model = NflPlayerViewModel.new(player, nil)
      model.stat_catagories_headers.should == ["Receiving", "Rushing"]
    end

    it "will be set correctly for a TE" do
      player = build(:nfl_player, :te)
      model = NflPlayerViewModel.new(player, nil)
      model.stat_catagories_headers.should == ["Receiving", "Rushing"]
    end

    it "will be set correctly for a DEF" do
      player = build(:nfl_player, :def)
      model = NflPlayerViewModel.new(player, nil)
      model.stat_catagories_headers.should == ["Defense"]
    end

    it "will be set correclt for a K" do
      player = build(:nfl_player, :pk)
      model = NflPlayerViewModel.new(player, nil)
      model.stat_catagories_headers.should == ["Kicking"]
    end
  end

  describe "colum header data returned correctly" do
    let(:pass_stat) { build(:stat_qb_good, week: 1) }
    let(:skill_stat) { build(:stat_wr_good, week: 3) }
    let(:def_stat) { build(:defense_stat, week: 6) }
    let(:league) { build(:league) }

    let(:model) { NflPlayerViewModel.new(nil, nil) }

    it "will return correct value for column 1" do
      model.col1_for_header(pass_stat).should == 1
      model.col1_for_header(skill_stat).should == 3
    end

    it "will return correct value for column 2" do
      model.col2_for_header(pass_stat, "passing").should == pass_stat.passing_yards
      model.col2_for_header(skill_stat, "rushing").should == skill_stat.rushing_yards
      model.col2_for_header(skill_stat, "receiving").should == skill_stat.receptions
      # model.col2_for_header(pass_stat, "kicking").should == pass_stat.field_goal_attempted
      model.col2_for_header(def_stat, "defense").should == def_stat.fumbles_recovered
    end

    it "will return correct value for column 3" do
      model.col3_for_header(pass_stat, "passing").should == pass_stat.passing_touchdowns
      model.col3_for_header(skill_stat, "rushing").should == skill_stat.rushing_touchdowns
      model.col3_for_header(skill_stat, "receiving").should == skill_stat.receiving_yards
      # model.col3_for_header(pass_stat, "kicking").should == pass_stat.field_goal_made
      model.col3_for_header(def_stat, "defense").should == def_stat.fumbles_recovered
    end

    it "will return correct value for column 4" do
      model.col4_for_header(pass_stat, "passing").should == pass_stat.passing_interceptions
      model.col4_for_header(skill_stat, "rushing").should == skill_stat.fumbles_lost
      model.col4_for_header(skill_stat, "receiving").should == skill_stat.receiving_touchdowns
      # model.col4_for_header(pass_stat, "kicking").should == pass_stat.field_goal_made
      model.col4_for_header(def_stat, "defense").should == def_stat.fumbles_recovered
    end

    it "will return correct value for column 5" do
      model.col5_for_header(pass_stat, league).should == pass_stat.total_points(league)
      model.col5_for_header(skill_stat, league).should == skill_stat.total_points(league)
      model.col5_for_header(nil, league).should == 0
    end
  end

  describe "player returns the player" do
    it "will return the player" do
      NflPlayerViewModel.new(nil, nil).player.should == nil
      player = build(:nfl_player)
      NflPlayerViewModel.new(player, nil).player.should == player
    end
  end

  describe "player position returns correct value" do
    it "will return correct position" do
      player = build(:nfl_player, :rb)
      NflPlayerViewModel.new(player, nil).player_position.should == Position::RUNNINGBACK
      NflPlayerViewModel.new(nil, nil).player.should == nil
    end
  end

end
