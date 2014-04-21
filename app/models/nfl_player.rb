class NflPlayer < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :position, :salary, :nfl_data_id

  belongs_to :nfl_team
  has_and_belongs_to_many :teams
  has_many :stats

  delegate :mascot, :to  => :nfl_team, :prefix => true

  def self.available_positions_for_filter
    ['all', 'qb', 'rb', 'wr', 'te', 'd', 'pk', 'flex']
  end

  # This is for pagination
  self.per_page = 15

  # Named_Scopes
  scope :positions, ->(pos) {
                              case pos.downcase
                              when 'all'
                                where(nil)
                              when 'flex'
                                where(:position => ['rb', 'wr'])
                              else
                                where(:position => pos.downcase)
                              end
                            }

  def full_name
    return read_attribute(:full_name) unless read_attribute(:full_name).nil?
    return "#{first_name} #{last_name}"
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
    player = NflPlayer.find_by(full_name: name, position: position.downcase, nfl_team: team)
    return player unless player.nil?

    names = get_name_variations(name).map do |in_name|
      NflPlayer.generate_hash(in_name, position, team.abbreviation)
    end

    match = NflPlayer.all.find do |player|
      next if player.nfl_team.nil?
      names.include?(NflPlayer.generate_hash(player.full_name, player.position, player.nfl_team.abbreviation))
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
    names
  end

end
