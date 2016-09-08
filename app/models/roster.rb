class Roster < ActiveRecord::Base
    validates :name, presence: true
    attr_accessible :name, :qb1, :rb1, :rb2, :wr1, :wr2, :te, :flex, :utility, :pk, :bench1, :bench2, :bench3, :bench4, :bench5, :bench6

    before_save :calculate_salary

    def calculate_salary
        player_ids = [self.qb1, self.rb1, self.rb2, 
                      self.wr1, self.wr2, self.te, 
                      self.flex, self.utility, self.pk,
                      self.bench1, self.bench2, self.bench3, 
                      self.bench4, self.bench5, self.bench6].flatten.uniq.compact
        self.salary = NflPlayer.where(id: player_ids).pluck(:salary).sum
    end
end