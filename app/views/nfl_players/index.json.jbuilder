json.array!(@nfl_players) do |nfl_player|
  json.extract! nfl_player, 
  json.url nfl_player_url(nfl_player, format: :json)
end
