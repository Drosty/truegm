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

  end

end
