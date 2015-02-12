module NflPlayersHelper

  def sortable_link(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end

  def display_team_name player
    display = ""
    if player.position != Position::DEFENSE && player.nfl_team != nil
      display = "#{player.nfl_team_full_name}"
    elsif player.position != Position::DEFENSE
      display = "Free Agent"
    end
    display
  end

  def link_to_players_owner_team player
    player_fantasy_team = player.fantasy_team(@current_league.id)
    return "FA" if player_fantasy_team.nil?

    link_to player_fantasy_team.name, team_path(player_fantasy_team)
  end

  def home_or_away_code player, current_week
    nfl_matchup = player.week_nfl_matchup(current_week)

    return "BYE" if nfl_matchup.nil? || player.nfl_team.nil?
    return nfl_matchup.home_or_away(player.nfl_team)
  end

  def opponent_code player, current_week
    nfl_matchup = player.week_nfl_matchup(current_week)

    return "" if nfl_matchup.nil?
    return nfl_matchup.opponent_code(player.nfl_team)
  end

  def matchup_formatted_date player, current_week
    nfl_matchup = player.week_nfl_matchup(current_week)

    return "" if nfl_matchup.nil?
    return nfl_matchup.game_date.in_time_zone("Central Time (US & Canada)").strftime("%a, %l:%M%P")
  end

  def matchup_tv_station player, current_week
    nfl_matchup = player.week_nfl_matchup(current_week)

    return "" if nfl_matchup.nil?
    return nfl_matchup.tv_station
  end

end
