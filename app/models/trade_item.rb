# == Schema Information
#
# Table name: trade_items
#
#  id         :integer          not null, primary key
#  trade_id   :integer
#  item_id    :integer
#  item_type  :string
#  team       :integer
#  value      :string
#  created_at :datetime
#  updated_at :datetime
#

class TradeItem < ActiveRecord::Base
  attr_accessible :item_id, :item_type, :team, :value

  belongs_to :trade
end
