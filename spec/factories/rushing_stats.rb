# == Schema Information
#
# Table name: rushing_stats
#
#  id                        :integer          not null, primary key
#  nfl_matchup_id            :integer
#  nfl_player_id             :integer
#  nfl_team_id               :integer
#  number                    :integer
#  position                  :string
#  fantasy_position          :string
#  fantasy_points            :float
#  fumbles_lost              :integer
#  rushing_attempts          :integer
#  rushing_long              :integer
#  rushing_touchdowns        :integer
#  rushing_yards             :integer
#  rushing_yards_per_attempt :float
#  two_point_conversion_runs :integer
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  week                      :integer
#  season                    :integer
#

FactoryGirl.define do
  factory :rushing_stat do
    nfl_matchup nil
nfl_player nil
nfl_team nil
number 1
position "MyString"
fantasy_position "MyString"
fantasy_points 1.5
fumbles_lost 1
rushing_attempts 1
rushing_long 1
rushing_touchdowns 1
rushing_yards 1
rushing_yards_per_attempt 1.5
two_point_conversion_runs 1
  end

end
