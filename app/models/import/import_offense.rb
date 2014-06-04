module Import
  class ImportOffense < BaseImport

    #TD is just there for the initializer part, not used
    #Yds is reception yards
    attr_accessor :Rk, :Player, :Team, :PassYds, :PassTDs,
                  :Int, :RushYds, :RushTds, :Rec, :Yds, :RecTds, :FumLost,
                  :FantasyPoints, :year, :week, :TD

    def create_or_update_and_return_player_model
      player = NflPlayer.find_or_create_by(nfl_data_id: nfl_player_import_id)
      player.first_name = first_name
      player.last_name = last_name
      player.full_name = self.Player
      player.position = self.Pos.downcase
      player.nfl_team = get_nfl_team
      player
    end

    def create_or_update_and_return_stats_model player_id
      stat = Stat.find_or_create_by(week: self.week, year: self.year, nfl_player_id: player_id)
      stat.passing_yards = self.PassYds
      stat.passing_touchdowns = self.PassTDs
      stat.interceptions = self.Int
      stat.rushing_yards = self.RushYds
      stat.rushing_touchdowns = self.RushTds
      stat.receptions = self.Rec
      stat.receiving_yards = self.Yds
      stat.receiving_touchdowns = self.RecTds
      stat.fumbles_lost = self.FumLost
      stat
    end

private

    def nfl_player_import_id
      NflPlayer.generate_hash self.Player, self.Pos, self.Team
    end

    def first_name
      self.Player.split(' ')[0]
    end

    def last_name
      parts = self.Player.split(' ')
      lname = parts[1]
      lname < parts[2] if parts.length > 2
      lname
    end

    def get_nfl_team
      NflTeam.find_or_create_by(abbreviation: self.Team)
    end

  end

end
