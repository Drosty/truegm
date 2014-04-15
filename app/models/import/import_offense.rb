module Import
  class ImportOffense

    attr_accessor :Rk, :Player, :Team, :Pos, :PassYds, :TD,
                  :Int, :RushYds, :Rec, :Yds, :FumLost,
                  :FantasyPoints, :year, :week

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name.gsub(/\s+/, "")}=", value)
      end
    end

    def process_player_stats
      player = create_or_update_and_return_player_model
      player.save
    end

  private

    def create_or_update_and_return_player_model
      player = NflPlayer.find_or_create_by(nfl_data_id: nfl_player_import_id)
      player.first_name = first_name
      player.last_name = last_name
      player.full_name = self.Player
      player.position = self.Pos
      player.nfl_team = get_nfl_team
      player
    end

    def nfl_player_import_id
      Zlib.crc32 "#{self.Player}#{self.Team}#{self.Pos}"
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
