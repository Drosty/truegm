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

    it "it will return the number of players per page" do
      request.accept = "application/json"
      get :index, { :league_id => 1 }
      assigns(:nfl_players).length.should == NflPlayer.per_page
    end

    it "it will return the correct league object" do
      request.accept = "application/json"
      get :index, { :league_id => 1 }
      assigns(:current_league).should == @league
    end

  end

  describe "GET show" do
    it "assigns the requested nfl_player as @nfl_player" do
    end
  end
end
