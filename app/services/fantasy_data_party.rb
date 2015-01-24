class FantasyDataParty
  include HTTParty

  # This is not right - change it to right one
  base_uri "http://api.nfldata.apiphany.com/enterprise/JSON"
  #debug_output $stdout

  def initialize(subscription_key = "test")
    @subscription_key = subscription_key
  end

  # Get active NFL Teams
  def nfl_teams
    response = self.class.get("/Teams?subscription-key=#{@subscription_key}")
    response.parsed_response
  end

  def get_roster_players_for_team team_name
    response = self.class.get("/Players/#{team_name}?subscription-key=#{@subscription_key}")
    response.parsed_response
  end

end
