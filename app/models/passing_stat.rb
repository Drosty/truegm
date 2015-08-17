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

class PassingStat < ActiveRecord::Base
  include FantasyDataMapper

  attr_accessible :week, :season, :nfl_player_id

  belongs_to :nfl_matchup 
  belongs_to :nfl_player
  belongs_to :nfl_team
end
