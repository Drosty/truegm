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
