class FantasyDataParty
  include HTTParty

  # This is not right - change it to right one
  base_uri "www.fantasyfootballnerd.com/service"

  def initialize(api_key = "test")
    @key = api_key
  end


  ##
  # This is an example of HttParty
  #
  #def nfl_teams
  #  response = self.class.get("/nfl-teams/json/#{@key}/")
  #  response.parsed_response["NFLTeams"].map do |team|
  #    Import::NflTeam.new(team)
  #  end
  #end


end
