require 'spec_helper'

describe NflPlayersController do
  include Warden::Test::Helpers
  render_views

  before (:each) do
    Warden.test_mode!

    @user = create(:user_with_one_team)
    sign_in(@user)

    @league = @user.teams[0].league
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
      assigns(:page).should == 1
      assigns(:current_league).should == @league
    end

    it "successfully paginates results" do
      request.accept = "application/json"
      get :index, { :league_id => @league.id, :page => -1 }
      first_call = assigns
      assigns(:nfl_players).length.should == NflPlayer.per_page

      get :index, { :league_id => @league.id, :page => 0 }
      assigns.should == first_call

      get :index, { :league_id => @league.id, :page => 1 }
      assigns.should == first_call

      get :index, { :league_id => @league.id, :page => 2 }
      assigns.should_not == first_call
      assigns(:nfl_players).length.should == NflPlayer.per_page

      get :index, { :league_id => @league.id, :page => 3 }
      assigns.should_not == first_call
      assigns(:nfl_players).length.should == 3

      get :index, { :league_id => @league.id, :page => 4 }
      assigns(:nfl_players).length.should == 0
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
    before(:each) do
      @nfl_player = create(:nfl_player, :qb,
                  full_name: "player one",
                  spotrac_url: "spotrac.com",
                  jersey: 12,
                  height: "6' 7\"",
                  weight: 230,
                  college: "Notre Dame",
                  active: true,
                  salary: 1250000,
                  nfl_team: create(:nfl_team, bye_week: 8))

      create(:stat_qb_good, nfl_player: @nfl_player, week: 1, year: 2013)
      create(:stat_qb_bad, nfl_player: @nfl_player, week: 2, year: 2014)
    end

    it "will return correct stats" do
      request.accept = "application/json"
      get :show, { :league_id => @league.id, :id => @nfl_player.id }

      data = JSON.parse(response.body)
      data["full_name"].should == "player one"
      data["bye_week"].should == @nfl_player.nfl_team.bye_week
      data["spotrac_url"].should == "spotrac.com"
      data["jersey"].should == "12"
      data["height"].should == "6' 7\""
      data["weight"].should == "230"
      data["salary"].should == "$1,250,000"
      data["college"].should == "Notre Dame"
      data["nfl_team"]["name"].should == "Full Football Team Name"
      data["is_on_team"].should == false
      data["is_free_agent"].should == true
      data["league_team"]["name"].should == "FA"
      data["stats"].should == {"year"=>[{"year"=>2013,"categories"=>[{"name"=>"Passing","stat_table_headers"=>["Wk", "Yds", "TD", "INT", "Pts"],"stats"=>[{"col1"=>1, "col2"=>300, "col3"=>3, "col4"=>0, "col5"=>27.0}]},{"name"=>"Rushing","stat_table_headers"=>["Wk", "Yds", "TD", "Fumbles", "Pts"],"stats"=>[{"col1"=>1, "col2"=>0, "col3"=>0, "col4"=>0, "col5"=>27.0}]}]},{"year"=>2014,"categories"=>[{"name"=>"Passing","stat_table_headers"=>["Wk", "Yds", "TD", "INT", "Pts"],"stats"=>[{"col1"=>2, "col2"=>150, "col3"=>1, "col4"=>2, "col5"=>4.0}]},{"name"=>"Rushing","stat_table_headers"=>["Wk", "Yds", "TD", "Fumbles", "Pts"],"stats"=>[{"col1"=>2, "col2"=>-10, "col3"=>0, "col4"=>1, "col5"=>4.0}]}]}]}
    end

    it "will return correct booleans around on team/free agent" do
      request.accept = "application/json"
      @nfl_player.teams = [@league.teams.first]
      get :show, { :league_id => @league.id, :id => @nfl_player.id }

      data = JSON.parse(response.body)
      data["is_on_team"].should == true
      data["is_free_agent"].should == false
      data["league_team"]["name"].should == @league.teams.first.name
    end
    
  end
end
