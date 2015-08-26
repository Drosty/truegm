# == Schema Information
#
# Table name: leagues
#
#  id                                               :integer          not null, primary key
#  name                                             :string
#  description                                      :string
#  tagline                                          :string
#  created_at                                       :datetime
#  updated_at                                       :datetime
#  salary_cap                                       :integer
#  passing_yard_points                              :float            default(0.04)
#  passing_touchdown_points                         :integer          default(5)
#  passing_interception_points                      :float            default(-2.0)
#  fumbles_lost_points                              :float            default(-2.0)
#  rushing_yards_points                             :float            default(0.1)
#  rushing_touchdown_points                         :integer          default(6)
#  receiving_yards_points                           :float            default(0.1)
#  receiving_touchdown_points                       :integer          default(6)
#  points_per_reception_points                      :float            default(1.0)
#  defensive_interception_points                    :float            default(2.0)
#  defensive_fumble_recovered_points                :float            default(2.0)
#  defensive_sack_points                            :integer          default(1)
#  defensive_saftey_points                          :integer          default(2)
#  defensive_touchdown_points                       :integer          default(6)
#  defensive_points_allowed_under_7_points          :float            default(10.0)
#  defensive_points_allowed_under_14_points         :float            default(7.0)
#  defensive_points_allowed_under_21_points         :float            default(1.0)
#  defensive_points_allowed_under_28_points         :float            default(0.0)
#  defensive_points_allowed_under_35_points         :float            default(-1.0)
#  defensive_points_allowed_equal_or_over_35_points :float            default(-4.0)
#  min_team_players                                 :integer          default(14)
#  max_team_players                                 :integer          default(15)
#  starting_qb_slots                                :integer          default(1)
#  starting_rb_slots                                :integer          default(2)
#  starting_wr_slots                                :integer          default(2)
#  starting_te_slots                                :integer          default(1)
#  starting_d_slots                                 :integer          default(1)
#  starting_flex_wrte_slots                         :integer          default(0)
#  starting_flex_rbwrte_slots                       :integer          default(1)
#  starting_k_slots                                 :integer          default(1)
#  player_salary_type                               :string           default("real")
#  ir_slots                                         :integer          default(1)
#  ir_players_tradeable                             :boolean          default(FALSE)
#  ir_cap_relief_max                                :integer          default(5000000)
#  ir_re_activatable                                :boolean          default(FALSE)
#  ir_reactivation_penalty                          :integer          default(0)
#  configuration_editable                           :boolean          default(TRUE)
#  playoffs_start_week                              :integer          default(13)
#

require 'spec_helper'

describe League do
  before(:each) do
    @league = build(:league)
  end

  it "Factory generates valid League" do
    @league.should be_valid
  end

  describe "League model is valid" do
    it "Should have a name" do
      @league.name = nil
      @league.should_not be_valid
    end

    it "Name has to be 5 characters at least" do
      @league.name = "1234"
      @league.should_not be_valid
    end

    it "Name can't be more than 20 characters" do
      @league.name = "123456789012345678901"
      @league.should_not be_valid
    end

    it "Should have a tagline" do
      @league.tagline = nil
      @league.should_not be_valid
    end
  end

  describe "methods that require teams set" do
    before(:each) do
      teams = [create(:team), create(:team), create(:team)]
      teams.each_with_index {|team, index| team.id = index+1 }
      @league.teams << teams
    end

    it "will return correct team ids" do
      @league.get_team_ids.should == [1,2,3]
    end

    it "will return the correct team for a player" do
      team = @league.teams.first
      player = create(:nfl_player, :wr)
      team.nfl_players << player
      team.save
      @league.get_team_name_for_player(player).should == team.name
    end

    it "will return FA if player is not on a team in the league" do
      player = create(:nfl_player, :rb)
      @league.get_team_name_for_player(player).should == "FA"
    end

  end

end
