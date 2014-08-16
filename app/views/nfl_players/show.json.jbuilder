json.(@nfl_player, :id, :full_name, :position, :spotrac_url, :jersey, :height, :weight, :college, :active)

json.salary format_as_money(@nfl_player.salary)

json.league_team do
  json.id player.fantasy_team(@current_league.id).id
  json.name player.fantasy_team(@current_league.id).name
end

json.stats do
  json.year [2012..2014].each do |year|

    json.year year

    json.headers ["PASS", "TDs", "STAT"].each do |header|
      json.name header
    end

    json.stats [0..10].each do |stat|

      json.stat stat
      json.runn stat
      json.lerad stat

    end

  end
end
