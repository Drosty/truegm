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
    nfl_players.sort_by { |a| NflPlayer.available_positions_for_filter.index(a.position) }
  end

  def have_roster_space_for_new_player?
    nfl_players.count < league.max_team_players
  end

  def would_be_under_minimum_roster_size_if_player_released?
    nfl_players.count-1 < league.min_team_players
  end

  def would_be_over_maximum_roster_size_if_player_added?
    nfl_players.count + 1 > league.max_team_players
  end

  def team_salary_if_player_released player
    self.total_salary - player.salary
  end

  def team_salary_if_player_added player
    self.total_salary + player.salary
  end

  def team_salary_if_player_released_and_other_added added_player, released_player
    self.total_salary + added_player.salary - released_player.salary
  end

  def add_player player
    team = player.fantasy_team self.league_id

    unless team.nil?
      team.nfl_players.delete(player)
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
    get_players_by_position Position::QUARTERBACK
  end

  def runningbacks
    get_players_by_position Position::RUNNINGBACK
  end

  def receivers
    get_players_by_position Position::WIDERECEIVER
  end

  def tightends
    get_players_by_position Position::TIGHTEND
  end

  def kickers
    get_players_by_position Position::KICKER
  end

  def defenses
    get_players_by_position Position::DEFENSE
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

  def update_total_salary
    self.total_salary = nfl_players.sum(:salary)
    self.total_salary = 0 if total_salary.nil? || total_salary < 0
  end

private

  def get_players_by_position position
    nfl_players.select { |p| p.position == position }
  end

end
