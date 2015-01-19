module SiteMaintenance
  class ProcessStatsService

    def initialize(league_id = nil)
      @leagues = [League.find(league_id)] unless league_id.nil?
      @leagues = League.all if @leagues.nil?
    end

    def process
      Stat.all.each do |stat|
        process_stat stat
      end
    end

  private

    def process_stat stat
      @leagues.each do |league|
        process_stat_for_league(stat, league)
      end
    end

    def process_stat_for_league stat, league
      processed_stat = ProcessedStat.find_or_create_by(stat_id: stat.id, league_id: league.id)
      processed_stat.value = stat.calculate_stat league
      processed_stat.save
    end

  end

end
