# == Schema Information
#
# Table name: power_rankings
#
#  id          :integer          not null, primary key
#  team_id     :integer
#  description :text
#  rank        :integer
#  week        :integer
#  year        :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe PowerRanking do
  before(:each) do
    @ranking = build(:power_ranking)
  end

  it "Factory generates valid ForumPost" do
    @ranking.should be_valid
  end

  it "Must have a description" do
    @ranking.description = nil
    @ranking.should_not be_valid
  end
end
