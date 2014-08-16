json.(view_model.player, :id, :full_name, :position, :spotrac_url, :jersey, :height, :weight, :college, :active)

json.salary format_as_money(@nfl_player.salary)

json.league_team do
  json.id view_model.player.fantasy_team(@current_league.id).id
  json.name view_model.player.fantasy_team(@current_league.id).name
end

json.stats do
  json.year view_model.stats_by_year.each do |stat_by_year|

    json.year stat_by_year[0]

    json.categories view_model.stat_catagories_headers.each do |header|
      json.name header

      json.stat_table_headers view_model.stat_table_headers(header)

      json.stats stat_by_year[1].each do |stat|

        json.col1 view_model.col1_for_header(stat, header)
        json.col2 view_model.col2_for_header(stat, header)
        json.col3 view_model.col3_for_header(stat, header)
        json.col4 view_model.col4_for_header(stat, header)
        json.col5 view_model.col5_for_header(stat, header, @current_league)

      end

    end

  end

end
