# == Schema Information
#
# Table name: leagues
#
#  id                                               :integer          not null, primary key
#  name                                             :string
#  description                                      :string
#  tagline                                          :string
#  created_at                                       :datetime
#  updated_at                                       :datetime
#  salary_cap                                       :integer
#  passing_yard_points                              :float            default(0.04)
#  passing_touchdown_points                         :integer          default(5)
#  passing_interception_points                      :float            default(-2.0)
#  fumbles_lost_points                              :float            default(-2.0)
#  rushing_yards_points                             :float            default(0.1)
#  rushing_touchdown_points                         :integer          default(6)
#  receiving_yards_points                           :float            default(0.1)
#  receiving_touchdown_points                       :integer          default(6)
#  points_per_reception_points                      :float            default(1.0)
#  defensive_interception_points                    :float            default(2.0)
#  defensive_fumble_recovered_points                :float            default(2.0)
#  defensive_sack_points                            :integer          default(1)
#  defensive_saftey_points                          :integer          default(2)
#  defensive_touchdown_points                       :integer          default(6)
#  defensive_points_allowed_under_7_points          :float            default(10.0)
#  defensive_points_allowed_under_14_points         :float            default(7.0)
#  defensive_points_allowed_under_21_points         :float            default(1.0)
#  defensive_points_allowed_under_28_points         :float            default(0.0)
#  defensive_points_allowed_under_35_points         :float            default(-1.0)
#  defensive_points_allowed_equal_or_over_35_points :float            default(-4.0)
#  min_team_players                                 :integer          default(14)
#  max_team_players                                 :integer          default(15)
#  starting_qb_slots                                :integer          default(1)
#  starting_rb_slots                                :integer          default(2)
#  starting_wr_slots                                :integer          default(2)
#  starting_te_slots                                :integer          default(1)
#  starting_d_slots                                 :integer          default(1)
#  starting_flex_wrte_slots                         :integer          default(0)
#  starting_flex_rbwrte_slots                       :integer          default(1)
#  starting_k_slots                                 :integer          default(1)
#  player_salary_type                               :string           default("real")
#  ir_slots                                         :integer          default(1)
#  ir_players_tradeable                             :boolean          default(FALSE)
#  ir_cap_relief_max                                :integer          default(5000000)
#  ir_re_activatable                                :boolean          default(FALSE)
#  ir_reactivation_penalty                          :integer          default(0)
#  configuration_editable                           :boolean          default(TRUE)
#  playoffs_start_week                              :integer          default(13)
#

class League < ActiveRecord::Base
  attr_accessible :description, :name, :tagline, :salary_cap,
                  :passing_yard_points, :passing_touchdown_points,
                  :passing_interception_points, :fumbles_lost_points,
                  :rushing_yards_points, :rushing_touchdown_points,
                  :receiving_yards_points, :receiving_touchdown_points,
                  :points_per_reception_points, :defensive_interception_points,
                  :defensive_fumble_recovered_points, :defensive_sack_points,
                  :defensive_saftey_points, :defensive_touchdown_points,
                  :defensive_points_allowed_under_7_points,
                  :defensive_points_allowed_under_14_points,
                  :defensive_points_allowed_under_21_points,
                  :defensive_points_allowed_under_28_points,
                  :defensive_points_allowed_under_35_points,
                  :defensive_points_allowed_equal_or_over_35_points

  has_many :teams, dependent: :destroy
  accepts_nested_attributes_for :teams, :allow_destroy => true

  has_many :forum_topics, dependent: :destroy

  validates_presence_of :tagline
  validates_length_of :name, :minimum => 5, :maximum => 20, :allow_blank => false

  def get_team_name_for_player nfl_player
    team = Team.joins(:nfl_players)
               .where(:teams => {:league_id => id}, :nfl_players => {:id => nfl_player.id})
               .first

    return "FA" if team.nil?
    team.name
  end

  def get_team_ids
    self.teams.map(&:id)
  end

end
