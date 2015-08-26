# == Schema Information
#
# Table name: draft_picks
#
#  id               :integer          not null, primary key
#  team_id          :integer
#  year             :integer
#  round            :integer
#  position         :integer
#  original_team_id :integer
#  created_at       :datetime
#  updated_at       :datetime
#

require 'spec_helper'

describe DraftPick do
  before(:each) do
    @pick = build(:draft_pick)
  end
  
  describe "model is valid" do
    it "Factory Generates Valid Model" do
      @pick.should be_valid
    end
    
    it "should have a year" do
      @pick.year = nil
      @pick.should_not be_valid
    end
    
    it "should have a round" do
      @pick.round = nil
      @pick.should_not be_valid
    end
    
    it "should have a original team" do
      @pick.original_team = nil
      @pick.should_not be_valid
    end
  end
end
