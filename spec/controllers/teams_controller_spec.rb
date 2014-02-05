require 'spec_helper'
require "cancan/matchers"

describe TeamsController do
  include Warden::Test::Helpers

  before (:each) do
    Warden.test_mode!
  end

  after (:each) do
    Warden.test_reset!
  end

  describe "Regular user - Visit Team Page" do
    before(:each) do
      @one_team_user = create(:user_with_one_team)
      login(@one_team_user)
      @ability = Ability.new(@one_team_user)
    end

    it 'can access team that are owner of' do
      visit team_path(@one_team_user.teams.first)
      page.should have_content(@one_team_user.teams.first.name)
    end

    it 'can access team that is in the same league' do
      league = @one_team_user.leagues.first
      new_team = create(:team, :league => league)

      visit team_path(new_team)
      page.should have_content(new_team.name)
    end 
    
    it 'cant access team in another league' do
      league = create(:league)
      team = create(:team, :league => league)

      assert @ability.cannot?(:read, create(:team, :league => league))
    end
  end
end
