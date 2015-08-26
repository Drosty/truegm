# == Schema Information
#
# Table name: return_stats
#
#  id                            :integer          not null, primary key
#  nfl_matchup_id                :integer
#  nfl_player_id                 :integer
#  nfl_team_id                   :integer
#  number                        :integer
#  position                      :string
#  fantasy_position              :string
#  fantasy_points                :float
#  kick_return_long              :integer
#  kick_return_touchdowns        :integer
#  kick_return_yards             :integer
#  kick_return_yards_per_attempt :float
#  kick_returns                  :integer
#  punt_return_long              :integer
#  punt_return_touchdowns        :integer
#  punt_return_yards             :integer
#  punt_return_yards_per_attempt :float
#  punt_returns                  :integer
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  week                          :integer
#  season                        :integer
#

FactoryGirl.define do
  factory :return_stat do
    nfl_matchup nil
nfl_player nil
nfl_team nil
number 1
position "MyString"
fantasy_position "MyString"
fantasy_points 1.5
kick_return_long 1
kick_return_touchdowns 1
kick_return_yards 1
kick_return_yards_per_attempt 1.5
kick_returns 1
punt_return_long 1
punt_return_touchdowns 1
punt_return_yards 1
punt_return_yards_per_attempt 1.5
punt_returns 1
  end

end
