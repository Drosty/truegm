# == Schema Information
#
# Table name: kicking_stats
#
#  id                       :integer          not null, primary key
#  nfl_matchup_id           :integer
#  nfl_player_id            :integer
#  nfl_team_id              :integer
#  number                   :integer
#  position                 :string
#  fantasy_position         :string
#  fantasy_points           :float
#  extra_points_attempted   :integer
#  extra_points_made        :integer
#  field_goal_percentage    :float
#  field_goals_attempted    :integer
#  field_goals_longest_made :integer
#  field_goals_made         :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  week                     :integer
#  season                   :integer
#

FactoryGirl.define do
  factory :kicking_stat do
    nfl_matchup nil
nfl_player nil
nfl_team nil
number 1
position "MyString"
fantasy_position "MyString"
fantasy_points 1.5
extra_points_attempted 1
extra_points_made 1
field_goal_percentage 1.5
field_goals_attempted 1
field_goals_longest_made 1
field_goals_made 1
  end

end
