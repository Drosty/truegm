class NflPlayer < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :position, :salary,
                  :nfl_team_id, :spotrac_url, :full_name, :jersey,
                  :height, :weight, :dob, :college, :active, :current_status,
                  :depth_order, :experience, :photo_url, :fantasy_data_id

  belongs_to :nfl_team
  has_and_belongs_to_many :teams
  has_many :stats

  delegate :code, :to  => :nfl_team, :prefix => true
  delegate :full_name, :to  => :nfl_team, :prefix => true
  delegate :bye_week, :to => :nfl_team, :allow_nil => true

  has_paper_trail :only => [:salary]

  def self.available_positions_for_filter
    Position::ALL_POSITION_INCLUDING_FLEX_AND_ALL
  end

  # This is for pagination
  self.per_page = 15

  # Named_Scopes
  scope :positions, ->(pos) {
                              case pos.downcase
                              when Position::ALL_STRING
                                all
                              when 'flex'
                                where(:position => Position::SKILL_POSITIONS)
                              when 'rb/wr/te'
                                where(:position => Position::SKILL_POSITIONS)
                              else
                                where(:position => pos.downcase)
                              end
                            }

  def self.with_salary
    where("salary IS NOT NULL and salary != 0")
  end

  def self.by_status(status, league)
    case status.downcase
    when 'free agent'
      includes(:teams).where("teams.id is null or teams.id not in (?)", league.teams.map(&:id)).references(:teams)
    when 'owned'
      includes(:teams).where({:teams => {:id => league.teams.map(&:id)}})
    else
      # all will fall to here
      all
    end
  end

  def self.search(name)
    if name
      where('lower(last_name) LIKE ?', "%#{name.downcase.strip}%")
    else
      all
    end
  end

  def is_on_fantasy_team team
    self.teams && self.teams.include?(team)
  end

  def age
    if dob
      ((Time.now - dob)/1.year).round
    else
      "NA"
    end
  end

  def full_name_with_nfl_team
    "#{full_name} - #{nfl_team.code}"
  end

  def week_nfl_matchup week, year
    self.nfl_team.week_nfl_matchup(week, year)
  end

  def points_in_week week, league
    year = ENV["current_year"]
    stat = self.stats.where(year: year, week: week).first
    return stat.total_points(league) unless stat.nil?
    return 0
  end

  def free_agent? league_id
    fantasy_team(league_id).nil?
  end

  def fantasy_team_name league_id
    ft = fantasy_team league_id
    return "FA" if ft.nil?
    return ft.name
  end

  def fantasy_team league_id
    self.teams.where(:league_id => league_id).first
  end

  def self.generate_hash name, pos, team_abbreviation
    name = name.gsub(/[^0-9A-Za-z]/, '').downcase
    pos = pos.gsub(/[^0-9A-Za-z]/, '').downcase
    team_abbreviation = team_abbreviation.gsub(/[^0-9A-Za-z]/, '').downcase
    Zlib.crc32 "#{name}#{pos}#{team_abbreviation}"
  end

  def self.fuzzy_find_by_spotrac name, position, team
    player = NflPlayer.find_by(full_name: name, position: position.upcase, nfl_team: team)
    return player unless player.nil?

    names = get_name_variations(name).map do |in_name|
      NflPlayer.generate_hash(in_name, position, team.code)
    end

    match = NflPlayer.all.find do |player|
      next if player.nfl_team.nil?
      names.include?(NflPlayer.generate_hash(player.full_name, player.position, player.nfl_team.code))
    end
    match
  end

private

  def self.get_name_variations name
    names = []
    names << name
    name = name.downcase
    names << name.gsub('jr', '')
    names << name.gsub('iii', '')
    names << name.gsub('rob', 'robert')
    names << name.gsub('joshua', 'josh')
    names << name.gsub('fozzy', 'foswhitt')
    names
  end

end
