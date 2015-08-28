class NflPlayerViewModel

  def initialize(player = nil, league = nil, user_team = nil)
    @player = player
    @league = league
    @user_fantasy_team = user_team
    @player_fantasy_team = @player.fantasy_team(@league.id) if @player && @league
  end

  def years_with_stats
    [2015, 2014, 2013]
  end

  def weeks
    (1..17)
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

  def col2_for_header header_category, year, week
    val = 0
    if is_passing_header?(header_category)
      stat = @player.passing_stats.where({season: year, week: week}).first
      val = stat.passing_yards if stat

    elsif is_rushing_header?(header_category)
      stat = @player.rushing_stats.where({season: year, week: week}).first
      val = stat.rushing_yards if stat

    elsif is_receiving_header?(header_category)
      stat = @player.receiving_stats.where({season: year, week: week}).first
      val = stat.receptions if stat

    elsif is_kicking_header?(header_category)
      stat = @player.kicking_stats.where({season: year, week: week}).first
      val = stat.field_goal_attempted if stat

    else
      # val = stat.fumbles_recovered
      val = 0
    end

    val = 0 if val.nil?
    val
  end

  def col3_for_header header_category, year, week
    val = 0
    if is_passing_header?(header_category)
      stat = @player.passing_stats.where({season: year, week: week}).first
      val = stat.passing_touchdowns if stat

    elsif is_rushing_header?(header_category)
      stat = @player.rushing_stats.where({season: year, week: week}).first
      val = stat.rushing_touchdowns if stat

    elsif is_receiving_header?(header_category)
      stat = @player.receiving_stats.where({season: year, week: week}).first
      val = stat.receiving_yards if stat

    elsif is_kicking_header?(header_category)
      stat = @player.kicking_stats.where({season: year, week: week}).first
      val = stat.field_goal_made if stat

    else
      # val = stat.fumbles_recovered
      val = 0

    end

    val = 0 if val.nil?
    val
  end

  def col4_for_header header_category, year, week
    val = 0
    if is_passing_header?(header_category)
      stat = @player.passing_stats.where({season: year, week: week}).first
      val = stat.passing_interceptions if stat

    elsif is_rushing_header?(header_category)
      stat = @player.rushing_stats.where({season: year, week: week}).first
      val = stat.fumbles_lost if stat

    elsif is_receiving_header?(header_category)
      stat = @player.receiving_stats.where({season: year, week: week}).first
      val = stat.receiving_touchdowns if stat

    elsif is_kicking_header?(header_category)
      stat = @player.kicking_stats.where({season: year, week: week}).first
      val = stat.extra_points_made if stat

    else
      # val = stat.fumbles_recovered
      val = 0

    end

    val = 0 if val.nil?
    val
  end

  def col5_for_header year, week
    player.points_in_week(week, year, @league)
  end

  def player
    @player
  end

  def player_position
    @player.position
  end

  def player_fantasy_team
    @player_fantasy_team
  end

  def user_fantasy_team
    @user_fantasy_team
  end

  def league
    @league
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
