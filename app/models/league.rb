class League < ActiveRecord::Base
  attr_accessible :description, :name, :tagline, :salary_cap

  has_many :teams
  accepts_nested_attributes_for :teams, :allow_destroy => true

  has_many :forum_topics

  validates_presence_of :tagline
  validates_length_of :name, :minimum => 5, :maximum => 20, :allow_blank => false

  def get_team_name_for_player nfl_player
    team = Team.joins(:nfl_players)
               .where(:teams => {:league_id => id}, :nfl_players => {:id => nfl_player.id})
               .first

    return "FA" if team.nil?
    team.name
  end

end
