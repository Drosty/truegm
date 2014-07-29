class ScheduleViewModel

  def initialize(nfl_matchups = [], league_matchups = [])
    @nfl_matchups = nfl_matchups
    @league_matchups = league_matchups
  end

  def nfl_matchups
    @nfl_matchups
  end

  def league_matchups
    @league_matchups
  end
  
end
