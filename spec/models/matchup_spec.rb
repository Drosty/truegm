# == Schema Information
#
# Table name: matchups
#
#  id           :integer          not null, primary key
#  year         :integer
#  week         :integer
#  home_team_id :integer
#  away_team_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe Matchup do
  before(:each) do
    @matchup = build(:matchup)
  end

  it "Factory Generates Valid Model" do
    @matchup.should be_valid
  end
end
