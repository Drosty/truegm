class Team < ActiveRecord::Base
  attr_accessible :name, :tagline, :total_salary, :invite_code

  belongs_to :league
  belongs_to :user

  has_many :draft_picks
  has_many :power_rankings
  has_many :trades
  has_many :trade_votes

  has_and_belongs_to_many :nfl_players

  before_save :update_total_salary

  delegate :name, :to => :user, :prefix => true

  def add_player player
    team = player.fantasy_team self.league_id

    unless team.nil?
      team.nfl_players.delete(player.id)
    end

    self.nfl_players << player
  end

  def quarterbacks
    get_players_by_position "QB"
  end

  def runningbacks
    get_players_by_position "RB"
  end

  def receivers
    get_players_by_position "WR"
  end

  def tightends
    get_players_by_position "TE"
  end

  def kickers
    get_players_by_position "K"
  end

  def defenses
    get_players_by_position "D"
  end

  def under_cap?
    return true if league.salary_cap.nil?
    self.total_salary < league.salary_cap
  end

private

  def update_total_salary
    self.total_salary = nfl_players.sum(:salary)
    self.total_salary = 0 if total_salary.nil? || total_salary < 0
  end

  def get_players_by_position position
    nfl_players.select { |p| p.position == position.upcase }
  end

end
