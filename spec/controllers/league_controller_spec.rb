require 'spec_helper'

describe LeaguesController do
  include Warden::Test::Helpers

  before (:each) do
    Warden.test_mode!
  end

  after (:each) do
    Warden.test_reset!
  end

  def valid_attributes
    attributes_for(:league)
  end

  describe "POST create as Admin User" do
    before(:each) do
      @one_team_user = create(:user_with_one_team, :admin)
      login(@one_team_user)
    end

    describe "with valid params" do
      it "creates a new League" do
        expect {
          page.driver.post leagues_path, :league => valid_attributes
        }.to change(League, :count).by(1)
      end

      it "assigns a newly created league as @league" do
        page.driver.post leagues_path, :league => valid_attributes
        League.last.attributes == valid_attributes
      end

      it "creates 18 teams for the league" do
        page.driver.post leagues_path, :league => valid_attributes
        League.last.teams.length.should == 10 
      end

      it "one of the teams is the current users" do
        page.driver.post leagues_path, :league => valid_attributes
        last_league = League.last
        last_league.teams.select{|n| n.user_id == @one_team_user.id}.count.should == 1
      end

      it "creates the 3 forums for the league" do
        page.driver.post leagues_path, :league => valid_attributes
        League.last.forum_topics.length.should == 3
      end
    end

    describe "with invalid params" do
      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        League.any_instance.stub(:save).and_return(false)
        page.driver.post leagues_path, {:league => {  }}
        response.should render_template("new")
      end
    end
  end

  describe "POST create as Regular User" do
    before(:each) do
      @one_team_user = create(:user_with_one_team)
      login(@one_team_user)
    end

    describe "with valid params" do
      it "cannot create a new League" do
        expect {
          page.driver.post leagues_path, :league => valid_attributes
        }.to change(League, :count).by(0)
      end
    end
  end

  describe "User with no team" do
    before(:each) do
      user = create(:user)
      login(user)
    end

    it "can get to league index page" do
      visit leagues_path
      page.should have_content(I18n.t('leagues.header'))
    end
  end

  describe "Non-Admin User with one team" do
    before(:each) do
      @one_team_user = create(:user_with_one_team)
      login(@one_team_user)
    end

    it "Should list league current user is in" do
      visit leagues_path
      page.should have_content(@one_team_user.leagues.first.name)
    end

    it "Can visit league page of league in" do
      visit league_path(@one_team_user.leagues.first)
      page.should have_content(@one_team_user.leagues.first.name)
    end

    it "Cannot visit league page of league not part of" do
      other_league = create(:league)
      visit league_path(other_league)
      page.should have_content(I18n.t('error.message'))
    end
  end

  describe "User with multiple teams" do
    before(:each) do
      @two_team_user = create(:user_with_two_teams)
      login(@two_team_user)
    end

    it "Should list league current user is in" do
      visit leagues_path
      find('#main').should have_content(@two_team_user.leagues[0].name)
      find('#main').should have_content(@two_team_user.leagues[1].name)
    end

    it "should see all pending invitation that the user has" do
      
    end
  end
  
  describe "SHOW as normal user" do
    before(:each) do 
      user = create(:user_with_one_team)
      login(user)
      @league = user.leagues.first
      3.times do 
        @league.teams << create(:team, :league => @league)
      end
    end

    it "should see all the teams on the page" do
      visit league_path @league
      find('#main').should have_content(@league.teams[0].name)
      find('#main').should have_content(@league.teams[1].name)
      find('#main').should have_content(@league.teams[2].name)
      find('#main').should have_content(@league.teams[3].name)
    end
    
    it "should be able to see an edit link to own team" do
    
    end
  end
end
