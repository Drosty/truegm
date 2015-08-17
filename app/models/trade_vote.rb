# == Schema Information
#
# Table name: trade_votes
#
#  id         :integer          not null, primary key
#  trade_id   :integer
#  team_id    :integer
#  vote       :string
#  created_at :datetime
#  updated_at :datetime
#

class TradeVote < ActiveRecord::Base
  attr_accessible :vote

  belongs_to :trade
  belongs_to :team

  validates_presence_of :team
  validates_presence_of :trade

end
