require 'spec_helper'

describe Team do
  before(:each) do
    @team = create(:team)
  end

  it "Factory generates valid Team" do
    @team.should be_valid
  end

  describe "Adding players to Team" do
    it "will add player to team" do
      @team.add_player build(:nfl_player)
      @team.nfl_players.count.should eq(1)
    end

    it "will remove from other team if in same league when adding" do
      league = @team.league
      player = create(:nfl_player)
      second_team = create(:team)

      league.teams << second_team

      second_team.add_player player
      @team.add_player player

      second_team.nfl_players.count.should eq(0)
      @team.nfl_players.count.should eq(1)
    end

    it "will update team salary when player added" do
      @team.add_player build(:nfl_player, salary: 1000)
      @team.save
      @team.total_salary.should eq(1000)
    end

    it "will update team salary when player added" do
      @team.add_player build(:nfl_player, salary: 1000)
      @team.add_player build(:nfl_player, salary: 1000)
      @team.save
      @team.total_salary.should eq(2000)
    end

    it "will update team salary when player moves to different team" do
      league = @team.league
      player = create(:nfl_player, salary: 1000)
      second_team = create(:team)

      league.teams << second_team

      second_team.add_player player
      @team.add_player player

      second_team.save
      @team.save

      second_team.total_salary.should eq(0)
      @team.total_salary.should eq(1000)
    end
  end

  describe "NFL Players on Team" do
    before(:each) do
      # create a valid team (unorderd for other tests)
      @team.nfl_players << build(:nfl_player, :te)
      @team.nfl_players << build(:nfl_player, :rb)
      @team.nfl_players << build(:nfl_player, :wr)
      @team.nfl_players << build(:nfl_player, :rb)
      @team.nfl_players << build(:nfl_player, :wr)
      @team.nfl_players << build(:nfl_player, :qb)
      @team.nfl_players << build(:nfl_player, :pk)
      @team.nfl_players << build(:nfl_player, :def)
    end

    it "should order the nfl players correctly" do
      ordered = @team.ordered_nfl_players
      ordered[0].position.should == "qb"
      ordered[1].position.should == "rb"
      ordered[2].position.should == "rb"
      ordered[3].position.should == "wr"
      ordered[4].position.should == "wr"
      ordered[5].position.should == "te"
      ordered[6].position.should == "d"
      ordered[7].position.should == "k"
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
      @team.save
      @team.total_salary.should == 300000
    end

    it "Add player and the salary changes" do
      @team.nfl_players << build(:nfl_player, :salary => 300000)
      @team.save
      @team.total_salary.should == 600000
    end
  end

  describe "Team must be valid based on League Settings" do
    before(:each) do
      league = build(:league)
      league.teams << @team
    end
  end

  describe "Salary Cap rules" do
    it "will return true when under the cap" do
      @team.league.salary_cap = 1000
      @team.total_salary = 100
      @team.under_cap?.should == true
    end

    it "will return the correct amount of cap delta when under" do
      @team.league.salary_cap = 1000
      @team.total_salary = 900
      @team.cap_delta.should == 100
    end

    it "will return the correct amount of cap delta when over" do
      @team.league.salary_cap = 1000
      @team.total_salary = 1200
      @team.cap_delta.should == 200
    end

    it "will return cap delta of total salary if league not set" do
      @team.league = nil
      @team.total_salary = 1200
      @team.cap_delta.should == 1200
    end

    it "will return false when over the cap" do
      @team.league.salary_cap = 1000
      @team.total_salary = 10000
      @team.under_cap?.should == false
    end

    it "will return false when equal to the cap" do
      @team.league.salary_cap = 1000
      @team.total_salary = 1000
      @team.under_cap?.should == false
    end

    it "will return true when salary cap is not set" do
      @team.league.salary_cap = nil
      @team.total_salary = 1000
      @team.under_cap?.should == true
    end

  end

end
