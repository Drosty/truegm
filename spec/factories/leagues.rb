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

FactoryGirl.define do
  factory :league do
    name "MyString"
    description "MyString"
    tagline "MyString"
    salary_cap 36000000

    player_salary_type "real"
    min_team_players 14
    max_team_players 15
    starting_qb_slots 1
    starting_rb_slots 2
    starting_wr_slots 2
    starting_te_slots 1
    starting_d_slots 1
    starting_flex_wrte_slots 0
    starting_flex_rbwrte_slots 1
    starting_k_slots 1
    ir_slots 1
    ir_players_tradeable false
    ir_cap_relief_max 5000000
    ir_re_activatable false
    ir_reactivation_penalty 0
    configuration_editable true
    playoffs_start_week 13

    factory :league_with_stats do
      passing_yard_points 0.04
      passing_touchdown_points 5
      passing_interception_points -2
      fumbles_lost_points -2
      rushing_yards_points 0.1
      rushing_touchdown_points 6
      receiving_yards_points 0.1
      receiving_touchdown_points 6
      points_per_reception_points 1
      defensive_interception_points 2
      defensive_fumble_recovered_points 2
      defensive_sack_points 1
      defensive_saftey_points 1
      defensive_touchdown_points 6
      defensive_points_allowed_under_7_points 10
      defensive_points_allowed_under_14_points 7
      defensive_points_allowed_under_21_points 1
      defensive_points_allowed_under_28_points 0
      defensive_points_allowed_under_35_points -1
      defensive_points_allowed_equal_or_over_35_points -4
    end

  end
end
