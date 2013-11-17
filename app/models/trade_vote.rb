class TradeVote < ActiveRecord::Base
  attr_accessible :vote

  belongs_to :trade
  belongs_to :team

  validates_presence_of :team
  validates_presence_of :trade

  def toggle_vote
    if self.vote == "down"
      self.vote = "up"
    else
      self.vote = "down"
    end
  end
end
