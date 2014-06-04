module Import
  class ImportDefense < BaseImport

    #TD is just there for the initializer part, not used
    #Yds is reception yards
    attr_accessor :Rk, :Team, :TFL, :Sacks, :QBHits,
                  :Int, :FumRec, :Safeties, :DefTD,
                  :ReturnTD, :PtsAllowed, :FantasyPoints,
                  :year, :week

    def initialize(attributes = {})
      super(attributes)
      self.Pos = "def"
    end

    def create_or_update_and_return_player_model
      player = NflPlayer.find_or_create_by(nfl_data_id: nfl_player_import_id)
      player.first_name = first_name
      player.last_name = last_name
      player.full_name = self.Team
      player.position = self.Pos
      player.nfl_team = nil
      player
    end

    def create_or_update_and_return_stats_model player_id
      stat = Stat.find_or_create_by(week: self.week, year: self.year, nfl_player_id: player_id)
      stat.tfl = self.TFL
      stat.sacks = self.Sacks
      stat.qbhits = self.QBHits
      stat.defensive_interceptions = self.Int
      stat.fumbles_recovered = self.FumRec
      stat.safties = self.Safeties
      stat.defensive_tds = self.DefTD
      stat.return_tds = self.ReturnTD
      stat.points_allowed = self.PtsAllowed

      stat
    end

  private

    def nfl_player_import_id
      NflPlayer.generate_hash self.Team, "def", "na"
    end

    def first_name
      parts = self.Team.split(' ')
      lname = parts[0]
      lname < parts[1] if parts.length > 2
      lname
    end

    def last_name
      parts = self.Team.split(' ')
      lname = parts[1] if parts.length == 2
      lname = parts[2] if parts.length > 2
      lname
    end

  end

end
