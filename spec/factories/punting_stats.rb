# == Schema Information
#
# Table name: punting_stats
#
#  id               :integer          not null, primary key
#  nfl_matchup_id   :integer
#  nfl_player_id    :integer
#  nfl_team_id      :integer
#  number           :integer
#  position         :string
#  fantasy_position :string
#  fantasy_points   :float
#  punt_average     :float
#  punt_inside20    :integer
#  punt_touchbacks  :integer
#  punt_yards       :integer
#  punts            :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  week             :integer
#  season           :integer
#

FactoryGirl.define do
  factory :punting_stat do
    nfl_matchup nil
nfl_player nil
nfl_team nil
number 1
position "MyString"
fantasy_position "MyString"
fantasy_points 1.5
punt_average 1.5
punt_inside20 1
punt_touchbacks 1
punt_yards 1
punts 1
  end

end
