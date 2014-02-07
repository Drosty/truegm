class TradeVote < ActiveRecord::Base
  attr_accessible :vote

  belongs_to :trade
  belongs_to :team

  validates_presence_of :team
  validates_presence_of :trade

end
