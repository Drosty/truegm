require 'spec_helper'

# Only actions to test are the Index and the Show
describe NflPlayersController do
  include Warden::Test::Helpers

  before (:each) do
    Warden.test_mode!
  end

  after (:each) do
    Warden.test_reset!
  end

  describe "GET index" do
    before(:each) do
      @user = create(:user)
      login(@user)

      @league = create(:league, id: 1)
      create_list(:nfl_player, 4, :qb)
      create_list(:nfl_player, 6, :rb)
      create_list(:nfl_player, 8, :wr)
      create_list(:nfl_player, 7, :te)
      create_list(:nfl_player, 5, :pk)
      create_list(:nfl_player, 3, :def)
    end

    it "it will return the number of players per page and the league" do
      request.accept = "application/json"
      get :index, { :league_id => 1 }
      assigns(:nfl_players).length.should == NflPlayer.per_page
      assigns(:status).should == "Free Agent"
      assigns(:position).should == Position::ALL_STRING
      assigns(:searchString).should == nil
      assigns(:page).should == nil
      assigns(:current_league).should == @league
    end

    it "will return the correct number of players by position" do
      request.accept = "application/json"
      get :index, { :league_id => 1, :position => Position::QUARTERBACK }
      assigns(:nfl_players).length.should == 4
      assigns(:total_players).should == 4
      assigns(:position).should == Position::QUARTERBACK

      get :index, { :league_id => 1, :position => Position::RUNNINGBACK }
      assigns(:nfl_players).length.should == 6
      assigns(:total_players).should == 6
      assigns(:position).should == Position::RUNNINGBACK

      get :index, { :league_id => 1, :position => Position::WIDERECEIVER }
      assigns(:nfl_players).length.should == 8
      assigns(:total_players).should == 8
      assigns(:position).should == Position::WIDERECEIVER

      get :index, { :league_id => 1, :position => Position::TIGHTEND }
      assigns(:nfl_players).length.should == 7
      assigns(:total_players).should == 7
      assigns(:position).should == Position::TIGHTEND

      get :index, { :league_id => 1, :position => Position::KICKER }
      assigns(:nfl_players).length.should == 5
      assigns(:total_players).should == 5
      assigns(:position).should == Position::KICKER

      get :index, { :league_id => 1, :position => Position::DEFENSE }
      assigns(:nfl_players).length.should == 3
      assigns(:total_players).should == 3
      assigns(:position).should == Position::DEFENSE
    end

  end

  describe "GET show" do
    it "assigns the requested nfl_player as @nfl_player" do
    end
  end
end
