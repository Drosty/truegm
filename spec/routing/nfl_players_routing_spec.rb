require "spec_helper"

describe NflPlayersController do
  describe "routing" do

    it "routes to #index" do
      get("/nfl_players").should route_to("nfl_players#index")
    end

    it "routes to #new" do
      get("/nfl_players/new").should route_to("nfl_players#new")
    end

    it "routes to #show" do
      get("/nfl_players/1").should route_to("nfl_players#show", :id => "1")
    end

    it "routes to #edit" do
      get("/nfl_players/1/edit").should route_to("nfl_players#edit", :id => "1")
    end

    it "routes to #create" do
      post("/nfl_players").should route_to("nfl_players#create")
    end

    it "routes to #update" do
      put("/nfl_players/1").should route_to("nfl_players#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/nfl_players/1").should route_to("nfl_players#destroy", :id => "1")
    end

  end
end
