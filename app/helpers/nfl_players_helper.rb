module NflPlayersHelper

  def sortable_link(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), {:class => css_class}
  end

  def display_team_name player
    display = ""
    if player.position != "def" && player.nfl_team != nil
      display = "#{player.nfl_team_full_name}"
    elsif player.position != "def"
      display = "Free Agent"
    end
    display
  end

  def link_to_players_owner_team player
    player_fantasy_team = player.fantasy_team(@current_league.id)
    return "FA" if player_fantasy_team.nil?

    link_to player_fantasy_team.name, team_path(player_fantasy_team)
  end

end
