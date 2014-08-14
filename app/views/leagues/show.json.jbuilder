json.(@current_league, :id, :name, :description, :tagline)

json.teams @current_league.teams do |team|
  json.(team, :id, :name)
  json.salary format_as_money(team.total_salary)

  json.user team.user, :id, :name unless team.user.nil?
  json.user nil if team.user.nil?
end
