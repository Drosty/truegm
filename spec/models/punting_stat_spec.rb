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

require 'spec_helper'

describe PuntingStat do
  pending "add some examples to (or delete) #{__FILE__}"
end
