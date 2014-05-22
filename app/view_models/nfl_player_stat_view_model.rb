class NflPlayerStatViewModel

  @stat_lines

  def initialize(stats = [])
    @stat_lines = stats
  end

  def stats_by_year
    @stat_lines.sort_by{ |stat| stat.week }.group_by { |stat| stat.year }
  end

end
