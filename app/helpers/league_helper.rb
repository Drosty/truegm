module LeagueHelper
  def salary_display_color_class team
    return "text-success" if team.under_cap?
    return "text-error"
  end
end
