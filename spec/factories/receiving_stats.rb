# == Schema Information
#
# Table name: receiving_stats
#
#  id                              :integer          not null, primary key
#  nfl_matchup_id                  :integer
#  nfl_player_id                   :integer
#  nfl_team_id                     :integer
#  number                          :integer
#  position                        :string
#  fantasy_position                :string
#  fantasy_points                  :float
#  fumbles_lost                    :integer
#  receiving_long                  :integer
#  receiving_targets               :integer
#  receiving_touchdowns            :integer
#  receiving_yards                 :integer
#  receiving_yards_per_reception   :float
#  receiving_yards_per_target      :float
#  reception_percentage            :float
#  receptions                      :integer
#  two_point_conversion_receptions :integer
#  created_at                      :datetime         not null
#  updated_at                      :datetime         not null
#  week                            :integer
#  season                          :integer
#

FactoryGirl.define do
  factory :receiving_stat do
    nfl_matchup nil
nfl_player nil
nfl_team nil
number 1
position "MyString"
fantasy_position "MyString"
fantasy_points 1.5
fumbles_lost 1
receiving_long 1
receiving_targets 1
receiving_touchdowns 1
receiving_yards 1
receiving_yards_per_reception 1.5
receiving_yards_per_target 1.5
reception_percentage 1.5
receptions 1
two_point_conversion_receptions 1
  end

end
