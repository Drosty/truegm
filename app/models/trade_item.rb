class TradeItem < ActiveRecord::Base
  attr_accessible :item_id, :item_type, :team, :value

  belongs_to :trade
end
