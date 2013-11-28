require "spec_helper"

describe NflPlayersController do
  describe "routing" do

    it "routes to #index" do
      get("/leagues/1/nfl_players").should route_to("nfl_players#index", :league_id => "1")
    end

    it "routes to #show" do
      get("/leagues/1/nfl_players/1").should route_to("nfl_players#show", {:league_id => "1", :id => "1"})
    end
  end
end
