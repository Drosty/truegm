class Team < ActiveRecord::Base
  include PublicActivity::Common

  attr_accessible :name, :tagline, :total_salary, :invite_code

  belongs_to :league
  belongs_to :user

  has_many :invites, dependent: :destroy
  has_many :draft_picks, dependent: :destroy
  has_many :power_rankings, dependent: :destroy

  has_and_belongs_to_many :nfl_players

  before_save :update_total_salary

  delegate :name, :to => :user, :prefix => true

  def ordered_nfl_players
    nfl_players.sort_by { |a| NflPlayer.available_positions_for_filter.index(a.position.downcase) }
  end

  def add_player player
    team = player.fantasy_team self.league_id

    unless team.nil?
      team.nfl_players.delete(player.id)
    end

    self.nfl_players << player
    if self.save
      self.create_activity action: 'add_player', owner: self.user.team_in_league(self.league.id), recipient: player
    end
  end

  def remove_player player
    team = player.fantasy_team self.league_id

    if team && team.id == self.id
      team.nfl_players.delete(player.id)

      if self.save
        self.create_activity action: 'remove_player', owner: self.user.team_in_league(self.league.id), recipient: player
      end
    end
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

  def cap_delta
    cap = league.salary_cap unless league.nil?
    cap = 0 if cap.nil?
    return (self.total_salary - cap).abs
  end

private

  def update_total_salary
    self.total_salary = nfl_players.sum(:salary)
    self.total_salary = 0 if total_salary.nil? || total_salary < 0
  end

  def get_players_by_position position
    nfl_players.select { |p| p.position == position.upcase || p.position == position.downcase }
  end

end
