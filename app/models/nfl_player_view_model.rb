class NflPlayerViewModel

  def initialize(player = nil, stats = [])
    @stat_lines = stats
    @player = player
  end

  def stats_by_year
    @stats_by_year ||= begin
      @stat_lines.sort_by{ |stat| stat.week }.group_by { |stat| stat.year }
    end
  end

  def stat_catagories_headers
    if @player.position == "QB"
      ["Passing", "Rushing"]
    elsif @player.position == "RB"
      ["Rushing", "Receiving"]
    elsif @player.position == "WR" ||
            @player.position == "TE"
      ["Receiving", "Rushing"]
    elsif @player.position == "K"
      ["Kicking"]
    else
      ["Defense"]
    end
  end

  def stat_table_headers header_category
    if header_category == "Passing"
      ["Wk", "Yds", "TD", "INT", "Pts"]
    elsif header_category == "Rushing"
      ["Wk", "Yds", "TD", "Fumbles", "Pts"]
    elsif header_category == "Receiving"
      ["Wk", "Rec", "Yds", "TD", "Pts"]
    elsif header_category == "Kicking"
      ["Wk", "FGM", "FGA", "XPM", "Pts"]
    elsif
      ["Wk", "FF", "FF", "INT", "Pts"]
    end
  end

  def col1_for_header stat, header_category
    val = stat.week
    val = 0 if val.nil?
    val
  end

  def col2_for_header stat, header_category
    val = 0
    if header_category == "Passing"
      val = stat.passing_yards
    elsif header_category == "Rushing"
      val = stat.rushing_yards
    elsif header_category == "Receiving"
      val = stat.receptions
    elsif header_category == "Kicking"
      val = stat.field_goal_attempted
    elsif
      val = stat.fumbles_recovered
    end
    val = 0 if val.nil?
    val
  end

  def col3_for_header stat, header_category
    val = 0
    if header_category == "Passing"
      val = stat.passing_touchdowns
    elsif header_category == "Rushing"
      val = stat.rushing_touchdowns
    elsif header_category == "Receiving"
      val = stat.receiving_yards
    elsif header_category == "Kicking"
      val = stat.field_goal_made
    elsif
      val = stat.fumbles_recovered
    end
    val = 0 if val.nil?
    val
  end

  def col4_for_header stat, header_category
    val = 0
    if header_category == "Passing"
      val = stat.interceptions
    elsif header_category == "Rushing"
      val = stat.fumbles
    elsif header_category == "Receiving"
      val = stat.receiving_touchdowns
    elsif header_category == "Kicking"
      val = stat.field_goal_made
    elsif
      val = stat.fumbles_recovered
    end
    val = 0 if val.nil?
    val
  end

  def col5_for_header stat, header_category, league
    val = stat.total_points(league)
    val = 0 if val.nil?
    val
  end

  def player
    @player
  end

  def player_position
    @player.position
  end

end
