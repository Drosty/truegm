module Import
  class BaseImport

    attr_accessor :Pos, :ID

    def initialize(attributes = {})
      attributes.each do |name, value|
        send("#{name.gsub(/\s+/, "")}=", value)
      end
    end

    def process_player_stats
      return unless ::NflPlayer.available_positions_for_filter.include?(self.Pos.downcase)

      player = create_or_update_and_return_player_model
      return if player.nil?
      player.save

      stat = create_or_update_and_return_stats_model player.id
      return if stat.nil?
      stat.save
    end
  end
end
