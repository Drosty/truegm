# == Schema Information
#
# Table name: nfl_players
#
#  id              :integer          not null, primary key
#  nfl_team_id     :integer
#  first_name      :string
#  last_name       :string
#  position        :string
#  salary          :integer
#  created_at      :datetime
#  updated_at      :datetime
#  spotrac_url     :string
#  full_name       :string
#  jersey          :string
#  height          :string
#  weight          :string
#  dob             :datetime
#  college         :string
#  active          :boolean
#  current_status  :string
#  depth_order     :integer
#  experience      :integer
#  photo_url       :string
#  fantasy_data_id :integer
#
require 'open-uri'
include ActionView::Helpers::NumberHelper

class NflPlayer < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :position, :salary,
                  :nfl_team_id, :spotrac_url, :full_name, :jersey,
                  :height, :weight, :dob, :college, :active, :current_status,
                  :depth_order, :experience, :photo_url, :fantasy_data_id

  belongs_to :nfl_team
  has_and_belongs_to_many :teams

  has_many :kicking_stats
  has_many :passing_stats
  has_many :punting_stats
  has_many :receiving_stats
  has_many :return_stats
  has_many :rushing_stats

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

  def full_name_with_salary
    "#{full_name} - #{number_to_currency(salary, precision: 0)}"
  end

  def full_name_with_salary_and_position
    "#{full_name} - #{number_to_currency(salary, precision: 0)} - #{position}"    
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
    return "" if self.nfl_team.nil?
    self.nfl_team.week_nfl_matchup(week, year)
  end

  def years_with_stats
    years = []
    years << kicking_stats.pluck('distinct season')
    years << passing_stats.pluck('distinct season')
    years << punting_stats.pluck('distinct season')
    years << receiving_stats.pluck('distinct season')
    years << return_stats.pluck('distinct season')
    years << rushing_stats.pluck('distinct season')

    years.flatten.uniq
  end

  def all_stat_lines week, season
    stat_lines = []
    stat_lines << kicking_stats.where(season: season, week: week).first
    stat_lines << passing_stats.where(season: season, week: week).first
    stat_lines << punting_stats.where(season: season, week: week).first
    stat_lines << receiving_stats.where(season: season, week: week).first
    stat_lines << return_stats.where(season: season, week: week).first
    stat_lines << rushing_stats.where(season: season, week: week).first

    stat_lines
  end

  def points_in_week week, year, league
    stat_lines = all_stat_lines(week, year)
    stat_lines.sum { |stat_line| stat_line.nil? ? 0 : stat_line.total_points(league) }
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

    match = NflPlayer.all.find do |player_loop|
      next if player_loop.nfl_team.nil?
      names.include?(NflPlayer.generate_hash(player_loop.full_name, player_loop.position, player_loop.nfl_team.code))
    end
    match
  end

  def update_spotrac_salary
    return if spotrac_url.nil? || spotrac_url.empty?

    player_page = Nokogiri::HTML(open(spotrac_url))
    salary_node = player_page.css("table.salaryTable").css("tr.salaryRow").css("td.salaryAmt.current-year").css("span.info")[0]

    if salary_node.nil?
      puts "#{full_name} :: Salary not found on table"
    end

    self.salary = salary_node.text.gsub(/[^\d]/, '').strip
    save
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
