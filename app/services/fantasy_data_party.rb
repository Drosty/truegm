class FantasyDataParty
  include HTTParty

  # f = FantasyDataParty.new(ENV["fantasy_data_api_key"])

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

  def nfl_schedule year_string
    response = self.class.get("/Schedules/#{year_string}?subscription-key=#{@subscription_key}")
    response.parsed_response
  end

  def weekly_stats year, week
    response = self.class.get("/BoxScores/#{year}/#{week}?subscription-key=#{@subscription_key}")
    response.parsed_response
  end

end
