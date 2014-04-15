require 'csv'

module FantasyData
  class ImportService

    def self.import_offense_files
      file_path = Rails.root.join('lib', 'import_data', 'offense')
      @files = Dir["#{file_path}/**/*"]
      for filename in @files
        puts "-- :: #{filename}"

        CSV.foreach(filename, :headers => true) do |row|
          o = Import::ImportOffense.new(row.to_hash)
          puts row.to_hash
          puts o.inspect
        end
      end
    end
  end

end
