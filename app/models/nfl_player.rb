class NflPlayer < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :position, :salary

  belongs_to :nfl_team

  has_and_belongs_to_many :teams
end
