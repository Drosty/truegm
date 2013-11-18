require 'spec_helper'

describe Team do
  before(:each) do
    @team = build(:team)
  end

  it "Factory generates valid Team" do
    @team.should be_valid
  end

  describe "general team valid rules" do
    it "cant have same invite code as team in same league" do
    
    end
    
    it "can have same invite code as team in different league" do
    
    end
  end

  describe "NFL Players on Team" do
    before(:each) do
      # create a valid team
      @team.nfl_players << build(:nfl_player, :qb)
      @team.nfl_players << build(:nfl_player, :rb)
      @team.nfl_players << build(:nfl_player, :rb)
      @team.nfl_players << build(:nfl_player, :wr)
      @team.nfl_players << build(:nfl_player, :wr)
      @team.nfl_players << build(:nfl_player, :te)
      @team.nfl_players << build(:nfl_player, :pk)
      @team.nfl_players << build(:nfl_player, :def)
    end

    it "should return the correct num of QBs" do
      @team.quarterbacks.size.should == 1
    end

    it "should return the correct num of RBs" do
      @team.runningbacks.size.should == 2
    end

    it "should return the correct num of WRs" do
      @team.receivers.size.should == 2
    end

    it "should return the correct num of TEs" do
      @team.tightends.size.should == 1
    end

    it "should return the correct num of Kickers" do
      @team.kickers.size.should == 1
    end

    it "should return the correct num of Defenses" do
      @team.defenses.size.should == 1
    end
  end

  describe "salary updates on cache column" do
    before(:each) do
      @team.nfl_players << build(:nfl_player, :qb, :salary => 100000)
      @team.nfl_players << build(:nfl_player, :rb, :salary => 200000)
    end

    it "should update salary on save" do
      @team.send(:update_total_salary).should == 300000
    end

    it "Add player and the salary changes" do
      @team.nfl_players << build(:nfl_player, :salary => 300000)
      @team.send(:update_total_salary).should == 600000
    end
  end

  describe "Team must be valid based on League Settings" do
    before(:each) do
      league = build(:league)
      league.teams << @team
    end

    it "cannot have more QBs than allowed" do 
      
    end

    it "cannot have more RBs than allowed" do 
      
    end
    
    it "cannot have more WRs than allowed" do 
      
    end
    
    it "cannot have more TEs than allowed" do 
      
    end
    
    it "cannot have more Kickers than allowed" do 
      
    end
    
    it "cannot have more Defenses than allowed" do 
      
    end
  end
end
