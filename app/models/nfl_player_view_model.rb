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
    if @player.position == Position::QUARTERBACK
      ["Passing", "Rushing"]

    elsif @player.position == Position::RUNNINGBACK
      ["Rushing", "Receiving"]

    elsif @player.position == Position::WIDERECEIVER ||
            @player.position == Position::TIGHTEND
      ["Receiving", "Rushing"]

    elsif @player.position == Position::KICKER
      ["Kicking"]

    else
      ["Defense"]
    end
  end

  def stat_table_headers header_category
    if is_passing_header?(header_category)
      ["Wk", "Yds", "TD", "INT", "Pts"]

    elsif is_rushing_header?(header_category)
      ["Wk", "Yds", "TD", "Fumbles", "Pts"]

    elsif is_receiving_header?(header_category)
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
    if is_passing_header?(header_category)
      val = stat.passing_yards

    elsif is_rushing_header?(header_category)
      val = stat.rushing_yards

    elsif is_receiving_header?(header_category)
      val = stat.receptions

    elsif is_kicking_header(header_category)
      val = stat.field_goal_attempted

    elsif
      val = stat.fumbles_recovered

    end

    val = 0 if val.nil?
    val
  end

  def col3_for_header stat, header_category
    val = 0
    if is_passing_header?(header_category)
      val = stat.passing_touchdowns

    elsif is_rushing_header?(header_category)
      val = stat.rushing_touchdowns

    elsif is_receiving_header?(header_category)
      val = stat.receiving_yards

    elsif is_kicking_header(header_category)
      val = stat.field_goal_made

    elsif
      val = stat.fumbles_recovered

    end

    val = 0 if val.nil?
    val
  end

  def col4_for_header stat, header_category
    val = 0
    if is_passing_header?(header_category)
      val = stat.passing_interceptions

    elsif is_rushing_header?(header_category)
      val = stat.fumbles_recovered

    elsif is_receiving_header?(header_category)
      val = stat.receiving_touchdowns

    elsif is_kicking_header(header_category)
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

  private

    def is_passing_header? category
      category.downcase == "passing"
    end

    def is_rushing_header? category
      category.downcase == "rushing"
    end

    def is_receiving_header? category
      category.downcase == "receiving"
    end

    def is_kicking_header? category
      category.downcase == "kicking"
    end

end
