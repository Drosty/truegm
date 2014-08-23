json.players @nfl_players do |player|
  json.(player, :id, :full_name, :position)
  json.salary format_as_money(player.salary)

  json.nfl_team_code player.nfl_team.code.upcase if player.nfl_team
  json.nfl_team_code "FA" unless player.nfl_team

  json.nfl_team do
    json.name player.nfl_team.full_name
    json.id player.nfl_team.id
  end if player.nfl_team

  json.league_team do
    json.id player.fantasy_team(@current_league.id).id if player.fantasy_team(@current_league.id)
    json.name player.fantasy_team_name(@current_league.id)
  end
end
