module Import
  class ImportOffense
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming

    attr_accessor :Rk, :Player, :Team, :Pos, :PassYds, :TD, :Int, :RushYds, :Rec, :Yds, :FumLost, :FantasyPoints

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name.gsub(/\s+/, "")}=", value)
      end
    end

    def persisted?
      false
    end

  end
end
