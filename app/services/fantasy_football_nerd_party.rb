class FantasyFootballNerdParty
  include HTTParty

  base_uri "www.fantasyfootballnerd.com/service"

  def nfl_teams
    response = self.class.get("/nfl-teams/json/test/")
    response.parsed_response["NFLTeams"]
  end

  def nfl_players position = nil
    rtn_response = nil
    if position.blank?
      # get all players, all positions
      response = self.class.get("/players/json/test/")
      rtn_response = response.parsed_response
    else
      # get position
      response = self.class.get("/players/json/test/#{position.upcase}/")
      rtn_response = response.parsed_response
    end

    rtn_response["Players"]
  end

  def nfl_schedule
    response = self.class.get("/schedule/json/test/")
    response.parsed_response["Schedule"]
  end

  def current_week
    response = self.class.get("/schedule/json/test/")
    response.parsed_response["currentWeek"].to_i
  end

end
