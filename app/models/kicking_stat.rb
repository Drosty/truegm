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

class KickingStat < ActiveRecord::Base
  include FantasyDataMapper

  attr_accessible :week, :season, :nfl_player_id

  belongs_to :nfl_matchup
  belongs_to :nfl_player
  belongs_to :nfl_team

  def total_points league
    # TODO - have these be on the league configuration for scoring
    [
      extra_points_made.to_i * 1,
      field_goals_made.to_i * 3
    ].sum.round(0)
  end
end
