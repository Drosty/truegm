class Roster < ActiveRecord::Base
    validates :name, presence: true
    attr_accessible :name, :qb1, :rb1, :rb2, :wr1, :wr2, :te, :flex, :utility, :pk, :bench1, :bench2, :bench3, :bench4, :bench5, :bench6
end
