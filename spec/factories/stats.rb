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

FactoryGirl.define do
  factory :stat do
    year 2014
    week 1

    factory :stat_qb_good do
      nfl_player { FactoryGirl.create(:nfl_player, :qb) }
      passing_yards 300
      passing_touchdowns 3
      passing_interceptions 0
      rushing_yards 0
      rushing_touchdowns 0
      receptions 0
      receiving_yards 0
      receiving_touchdowns 0
      fumbles_lost 0
    end

    factory :stat_qb_bad do
      nfl_player { FactoryGirl.create(:nfl_player, :qb) }
      passing_yards 150
      passing_touchdowns 1
      passing_interceptions 2
      rushing_yards -10
      rushing_touchdowns 0
      receptions 0
      receiving_yards 0
      receiving_touchdowns 0
      fumbles_lost 1
    end

    factory :stat_rb_good do
      nfl_player { FactoryGirl.create(:nfl_player, :rb) }
      passing_yards 0
      passing_touchdowns 0
      passing_interceptions 0
      rushing_yards 130
      rushing_touchdowns 2
      receptions 4
      receiving_yards 40
      receiving_touchdowns 1
      fumbles_lost 0
    end

    factory :stat_rb_bad do
      nfl_player { FactoryGirl.create(:nfl_player, :rb) }
      passing_yards 0
      passing_touchdowns 0
      passing_interceptions 0
      rushing_yards 35
      rushing_touchdowns 0
      receptions 1
      receiving_yards 7
      receiving_touchdowns 0
      fumbles_lost 1
    end

    factory :stat_wr_good do
      nfl_player { FactoryGirl.create(:nfl_player, :wr) }
      passing_yards 0
      passing_touchdowns 0
      passing_interceptions 0
      rushing_yards 18
      rushing_touchdowns 0
      receptions 12
      receiving_yards 137
      receiving_touchdowns 2
      fumbles_lost 0
    end

    factory :stat_wr_bad do
      nfl_player { FactoryGirl.create(:nfl_player, :wr) }
      passing_yards 0
      passing_touchdowns 0
      passing_interceptions 0
      rushing_yards -4
      rushing_touchdowns 0
      receptions 2
      receiving_yards 7
      receiving_touchdowns 0
      fumbles_lost 1
    end

    factory :stat_te_good do
      nfl_player { FactoryGirl.create(:nfl_player, :te) }
      passing_yards 0
      passing_touchdowns 0
      passing_interceptions 0
      rushing_yards 18
      rushing_touchdowns 0
      receptions 12
      receiving_yards 137
      receiving_touchdowns 2
      fumbles_lost 0
    end

    factory :stat_te_bad do
      nfl_player { FactoryGirl.create(:nfl_player, :te) }
      passing_yards 0
      passing_touchdowns 0
      passing_interceptions 0
      rushing_yards -4
      rushing_touchdowns 0
      receptions 2
      receiving_yards 7
      receiving_touchdowns 0
      fumbles_lost 1
    end


    factory :defense_stat do
      nfl_player { FactoryGirl.create(:nfl_player, :def) }
      tfl 8
      defensive_interceptions 4
      fumbles_recovered 3
      safties 2
      defensive_tds 1
      points_allowed 11
    end

  end

end
