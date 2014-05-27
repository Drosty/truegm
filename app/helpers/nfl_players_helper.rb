module NflPlayersHelper

  def sortable_link(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  def display_team_name player
    display = ""
    if player.position != "def" && player.nfl_team != nil
      display = "#{player.nfl_team.location} #{player.nfl_team.mascot}"
    elsif player.position != "def"
      display = "Free Agent"
    end
    display
  end

end
