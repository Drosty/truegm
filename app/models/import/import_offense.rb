module Import
  class ImportOffense
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_accessor :Rk, :Player, :Team, :Pos, :PassYds, :TD,
                  :Int, :RushYds, :Rec, :Yds, :FumLost,
                  :FantasyPoints, :year, :week

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name.gsub(/\s+/, "")}=", value)
      end
    end

    def persisted?
      false
    end

    def process_player_stats

    end

    def nfl_player_import_id
      Zlib.crc32 "#{Player}#{Team}#{Pos}"
    end

  end

end
