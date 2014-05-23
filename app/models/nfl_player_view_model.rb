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

  def player
    @player
  end

  def player_position
    @player.position
  end

end
