module Import
  class Stat < BaseImport
    attr_accessor :playerId, :week, :year, :opponent, :gamePlayed, :gameStarted,
                  :finalScore, :completions, :passAttempts, :percentage, :passYards,
                  :avgPassYards, :passTD, :interceptions, :QBRating, :rushAttempts,
                  :rushYards, :rushAvg, :rushTD, :longRun, :fumble, :fumbleLost,
                  :receptions, :recYards, :recAvg, :longRec, :gameDate, :Sacks,
                  :SackYards, :recTD

  end
end
