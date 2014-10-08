class PlayerSalaryInformation < ActiveRecord::Base
  attr_accessible :player_name, :position, :team, :salary, :projection, :week
end
