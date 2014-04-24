require 'csv'

module FantasyData
  class ImportService

    def self.import_offense_files
      file_path = Rails.root.join('lib', 'import_data', 'offense')
      @files = Dir["#{file_path}/**/*"]
      for filename in @files
        week = get_week_from_file filename
        year = get_year_from_file filename

        CSV.foreach(filename, :headers => true) do |row|
          object = Import::ImportOffense.new(row.to_hash)
          object.PassTDs = row[5]
          object.RushTds = row[8]
          object.RecTds = row[11]
          object.week = week
          object.year = year
          object.process_player_stats
        end
      end
    end

  private

    def self.get_week_from_file filename
      filename = File.basename(filename)
      filename = filename.split('_')[1]
      filename
    end

    def self.get_year_from_file filename
      filename = File.basename(filename)
      filename = filename.split('_')[0]
      filename
    end

  end

end