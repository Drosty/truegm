module ApplicationHelper
  def is_admin_page?
    controller.class.name.split("::").first=="Admin"
  end

  def position_team_display_for_player player
    team_code = player.nfl_team == nil ? "FA" : player.nfl_team_code
    return "#{player.position.upcase} - #{team_code}"
  end

  def format_as_money input_string
    number_to_currency input_string, precision: 0
  end

end
