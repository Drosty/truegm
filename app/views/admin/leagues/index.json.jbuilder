json.array!(@admin_leagues) do |admin_league|
  json.extract! admin_league, 
  json.url admin_league_url(admin_league, format: :json)
end
