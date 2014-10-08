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
          page.driver.post admin_leagues_path, :league => valid_attributes
        }.to change(League, :count).by(1)
      end

      it "assigns a newly created league as @league" do
        page.driver.post admin_leagues_path, :league => valid_attributes
        League.last.attributes == valid_attributes
      end

      it "creates 10 teams for the league" do
        page.driver.post admin_leagues_path, {:league => valid_attributes, :number_of_teams => 10}
        League.last.teams.length.should == 10
      end

    end

  end

end
