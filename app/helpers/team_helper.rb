module TeamHelper

  def matchup_for_table_row team, nfl_matchup
    return "BYE" if nfl_matchup.nil? || team.nil?

    home_or_away = nfl_matchup.home_or_away(team)
    opponent_code = nfl_matchup.opponent_code(team)

    formatted_date = nfl_matchup.game_date.in_time_zone("Central Time (US & Canada)").strftime("%a, %l:%M%P")

    content_tag(:span, "#{home_or_away} #{opponent_code}") +
    tag("br") +
    content_tag(:span, "#{formatted_date} #{nfl_matchup.tv_station}")
  end

end
