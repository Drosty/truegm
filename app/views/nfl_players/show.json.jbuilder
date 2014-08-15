json.(@nfl_player, :id, :full_name, :position, :spotrac_url, :jersey, :height, :weight, :college, :active)

json.salary format_as_money(@nfl_player.salary)

json.league_team do
  json.id player.fantasy_team(@current_league.id).id
  json.name player.fantasy_team(@current_league.id).name
end

json.stats do
  nil
end
