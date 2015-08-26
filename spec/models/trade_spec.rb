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

require 'spec_helper'

describe Trade do
  before(:each) do
    @trade = build(:trade)
  end

  it "Factory Generates Valid Model" do
    @trade.should be_valid
  end
end
