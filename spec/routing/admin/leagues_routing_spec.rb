require "spec_helper"

describe Admin::LeaguesController do
  describe "routing" do

    it "routes to #index" do
      get("/admin/leagues").should route_to("admin/leagues#index")
    end

    it "routes to #new" do
      get("/admin/leagues/new").should route_to("admin/leagues#new")
    end

    it "routes to #show" do
      get("/admin/leagues/1").should route_to("admin/leagues#show", :id => "1")
    end

    it "routes to #edit" do
      get("/admin/leagues/1/edit").should route_to("admin/leagues#edit", :id => "1")
    end

    it "routes to #create" do
      post("/admin/leagues").should route_to("admin/leagues#create")
    end

    it "routes to #update" do
      put("/admin/leagues/1").should route_to("admin/leagues#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/admin/leagues/1").should route_to("admin/leagues#destroy", :id => "1")
    end

  end
end
