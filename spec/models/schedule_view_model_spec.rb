require 'spec_helper'

describe ScheduleViewModel do
  before(:each) do
    @matchups = [build(:nfl_matchup), build(:nfl_matchup)]
    @league_matchups = [build(:matchup), build(:matchup)]
    @model = ScheduleViewModel.new(@matchups, @league_matchups)
  end

  it "will return the right matchups" do
    @model.nfl_matchups.should == @matchups
  end

  it "will return the league matchups" do
    @model.league_matchups.should == @league_matchups
  end

end
