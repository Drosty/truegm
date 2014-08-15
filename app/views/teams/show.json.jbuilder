json.(@team, :id, :name, :tagline)
json.salary format_as_money(@team.total_salary)
json.user @team.user, :id, :name unless @team.user.nil?
json.under_cap @team.under_cap?
json.cap_delta format_as_money(@team.cap_delta)
json.current_week current_week

json.league do
  json.(@team.league, :id, :name, :description, :tagline)

  json.teams @team.league.teams do |team|
    json.(team, :id, :name)
    json.salary format_as_money(team.total_salary)

    json.user team.user, :id, :name unless team.user.nil?
    json.user nil if team.user.nil?
  end

end

json.players @team.nfl_players do |player|
  json.(player, :full_name, :position)
  json.salary format_as_money(player.salary)
  json.points player.points_in_week(current_week, @current_league)

  json.team_name player.nfl_team.code unless player.nfl_team.nil?
  json.team_name nil if player.nfl_team.nil?

  json.home_or_away_code home_or_away_code(player, current_week)
  json.opponent_code opponent_code(player, current_week)
  json.matchup_formatted_date matchup_formatted_date(player, current_week)
  json.matchup_tv_station matchup_tv_station(player, current_week)
end
