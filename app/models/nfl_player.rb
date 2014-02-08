class NflPlayer < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :position, :salary

  belongs_to :nfl_team

  has_and_belongs_to_many :teams

  delegate :mascot => :nfl_team, :prefix => true

  def self.available_positions_for_filter
    ['all', 'qb', 'rb', 'wr', 'te', 'd', 'k', 'flex']
  end

  # This is for pagination
  self.per_page = 15

  # Named_Scopes
  scope :positions, ->(pos) {
                              case pos
                              when 'all'
                                where(nil)
                              when 'flex'
                                where(:position => ['rb', 'wr'])
                              else
                                where(:position => pos)
                              end
                            }
end
