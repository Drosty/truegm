require 'spec_helper'

# Only actions to test are the Index and the Show
describe NflPlayersController do
  include Warden::Test::Helpers

  before (:each) do
    Warden.test_mode!

    @user = create(:user)
    login(@user)

    @league = create(:league)
    @league.teams << create(:team)
  end

  after (:each) do
    Warden.test_reset!
  end

  describe "index action to search players" do
    before(:each) do
      create(:nfl_player, :last_name => "Smith")
      create(:nfl_player, :last_name => "DesMither")
    end

    it "will return the right players by search term" do
      request.accept = "application/json"
      get :index, { :league_id => @league.id, :player_name => "smith" }

      assigns(:nfl_players).length.should == 2
      assigns(:total_players).should == 2
    end

    it "will return the right players by search term" do
      request.accept = "application/json"
      get :index, { :league_id => @league.id, :player_name => "DesMith" }

      assigns(:nfl_players).length.should == 1
      assigns(:total_players).should == 1
    end
  end

  describe "index action to retrieve players and counts" do
    before(:each) do
      create_list(:nfl_player, 4, :qb, teams: [])
      create_list(:nfl_player, 6, :rb, teams: [])
      create_list(:nfl_player, 8, :wr, teams: [])
      create_list(:nfl_player, 7, :te, teams: [])
      create_list(:nfl_player, 5, :pk, teams: [])
      create_list(:nfl_player, 3, :def, teams: [])
    end

    it "it will return the number of players per page and the league" do
      request.accept = "application/json"
      get :index, { :league_id => @league.id }
      assigns(:nfl_players).length.should == NflPlayer.per_page
      assigns(:total_players).should == 33
      assigns(:status).should == "Free Agent"
      assigns(:position).should == Position::ALL_STRING
      assigns(:searchString).should == nil
      assigns(:page).should == nil
      assigns(:current_league).should == @league
    end

    it "will return the correct number of players by position" do
      request.accept = "application/json"
      get :index, { :league_id => @league.id, :position => Position::QUARTERBACK }
      assigns(:nfl_players).length.should == 4
      assigns(:total_players).should == 4
      assigns(:position).should == Position::QUARTERBACK

      get :index, { :league_id => @league.id, :position => Position::RUNNINGBACK }
      assigns(:nfl_players).length.should == 6
      assigns(:total_players).should == 6
      assigns(:position).should == Position::RUNNINGBACK

      get :index, { :league_id => @league.id, :position => Position::WIDERECEIVER }
      assigns(:nfl_players).length.should == 8
      assigns(:total_players).should == 8
      assigns(:position).should == Position::WIDERECEIVER

      get :index, { :league_id => @league.id, :position => Position::TIGHTEND }
      assigns(:nfl_players).length.should == 7
      assigns(:total_players).should == 7
      assigns(:position).should == Position::TIGHTEND

      get :index, { :league_id => @league.id, :position => Position::KICKER }
      assigns(:nfl_players).length.should == 5
      assigns(:total_players).should == 5
      assigns(:position).should == Position::KICKER

      get :index, { :league_id => @league.id, :position => Position::DEFENSE }
      assigns(:nfl_players).length.should == 3
      assigns(:total_players).should == 3
      assigns(:position).should == Position::DEFENSE
    end

    it "will return correct number players by status" do
      request.accept = "application/json"

      team = @league.teams.first
      create_list(:nfl_player, 6, teams: [team])

      get :index, { :league_id => @league.id, :own_status => "owned" }
      assigns(:nfl_players).length.should == 6
      assigns(:total_players).should == 6

      get :index, { :league_id => @league.id, :own_status => "free agent" }
      assigns(:nfl_players).length.should == NflPlayer.per_page
      assigns(:total_players).should == 33

      get :index, { :league_id => @league.id, :own_status => nil }
      assigns(:nfl_players).length.should == NflPlayer.per_page
      assigns(:total_players).should == 33

      get :index, { :league_id => @league.id, :own_status => "all" }
      assigns(:nfl_players).length.should == NflPlayer.per_page
      assigns(:total_players).should == 39
    end

  end

  describe "GET show" do
    it "assigns the requested nfl_player as @nfl_player" do
    end
  end
end
