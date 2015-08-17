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

require 'spec_helper'

describe KickingStat do
  pending "add some examples to (or delete) #{__FILE__}"
end
