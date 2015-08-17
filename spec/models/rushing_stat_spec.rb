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

require 'spec_helper'

describe RushingStat do
  pending "add some examples to (or delete) #{__FILE__}"
end
