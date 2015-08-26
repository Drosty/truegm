# == Schema Information
#
# Table name: trades
#
#  id           :integer          not null, primary key
#  from_team_id :integer
#  to_team_id   :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Trade < ActiveRecord::Base
  has_many :trade_items
  has_many :trade_votes
  belongs_to :from_team, :foreign_key => 'from_team_id', :class_name => "Team"
  belongs_to :to_team, :foreign_key => 'to_team_id', :class_name => "Team"
end
