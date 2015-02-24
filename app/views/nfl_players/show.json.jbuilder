json.(view_model.player, :id, :full_name, :bye_week, :spotrac_url, :jersey, :height, :weight, :college, :active)
json.position view_model.player.position.upcase
json.salary format_as_money(view_model.player.salary)
json.age view_model.player.age
json.photo_url view_model.player.photo_url

json.nfl_team do
  json.name view_model.player.nfl_team.full_name unless view_model.player.nfl_team.nil?
  json.id view_model.player.nfl_team.id unless view_model.player.nfl_team.nil?
end

json.is_on_team view_model.player.is_on_fantasy_team(view_model.fantasy_team)

if view_model.fantasy_team
  json.is_free_agent false
  json.league_team do
    json.id view_model.fantasy_team.id
    json.name view_model.fantasy_team.name
  end
else
  json.is_free_agent true
  json.league_team do
    json.id nil
    json.name "FA"
  end
end

json.stats do
  json.year view_model.stats_by_year.each do |stat_by_year|
    json.year stat_by_year[0]

    json.categories view_model.stat_catagories_headers.each do |header|
      json.name header
      json.stat_table_headers view_model.stat_table_headers(header)

      json.stats stat_by_year[1].each do |stat|
        json.col1 view_model.col1_for_header(stat)
        json.col2 view_model.col2_for_header(stat, header)
        json.col3 view_model.col3_for_header(stat, header)
        json.col4 view_model.col4_for_header(stat, header)
        json.col5 view_model.col5_for_header(stat, view_model.league)
      end
    end
  end
end
