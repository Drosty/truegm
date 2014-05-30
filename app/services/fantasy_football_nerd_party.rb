class FantasyFootballNerdParty
  include HTTParty

  base_uri "www.fantasyfootballnerd.com/service"

  def nfl_teams
    response = self.class.get("/nfl-teams/json/test/")
    response.parsed_response["NFLTeams"]
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
