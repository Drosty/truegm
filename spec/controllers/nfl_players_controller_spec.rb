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
      assigns(:current_league).should == @league
    end

    it "will return the correct number of players by position" do
      request.accept = "application/json"
      get :index, { :league_id => 1, :position => Position::QUARTERBACK }
      assigns(:nfl_players).length.should == 4

      get :index, { :league_id => 1, :position => Position::RUNNINGBACK }
      assigns(:nfl_players).length.should == 6

      get :index, { :league_id => 1, :position => Position::WIDERECEIVER }
      assigns(:nfl_players).length.should == 8

      get :index, { :league_id => 1, :position => Position::TIGHTEND }
      assigns(:nfl_players).length.should == 7

      get :index, { :league_id => 1, :position => Position::KICKER }
      assigns(:nfl_players).length.should == 5

      get :index, { :league_id => 1, :position => Position::DEFENSE }
      assigns(:nfl_players).length.should == 3
    end

  end

  describe "GET show" do
    it "assigns the requested nfl_player as @nfl_player" do
    end
  end
end
