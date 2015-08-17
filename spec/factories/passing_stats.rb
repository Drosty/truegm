# == Schema Information
#
# Table name: passing_stats
#
#  id                            :integer          not null, primary key
#  nfl_matchup_id                :integer
#  nfl_player_id                 :integer
#  nfl_team_id                   :integer
#  number                        :integer
#  position                      :string
#  fantasy_position              :string
#  fantasy_points                :float
#  passing_attempts              :integer
#  passing_completion_percentage :float
#  passing_completions           :integer
#  passing_interceptions         :integer
#  passing_long                  :integer
#  passing_rating                :float
#  passing_sack_yards            :integer
#  passing_sacks                 :integer
#  passing_touchdowns            :integer
#  passing_yards                 :integer
#  passing_yards_per_attempt     :float
#  passing_yards_per_completion  :float
#  two_point_conversion_passes   :integer
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  week                          :integer
#  season                        :integer
#

FactoryGirl.define do
  factory :passing_stat do
    nfl_matchup nil
nfl_player nil
nfl_team nil
number 1
position "MyString"
fantasy_position "MyString"
fantasy_points 1.5
passing_attempts 1
passing_completion_percentage 1.5
passing_completions 1
passing_interceptions 1
passing_long 1
passing_rating 1.5
passing_sack_yards 1
passing_sacks 1
passing_touchdowns 1
passing_yards 1
passing_yards_per_attempt 1.5
passing_yards_per_completion 1.5
two_point_conversion_passes 1
  end

end
