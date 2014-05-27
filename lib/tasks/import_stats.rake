namespace :import_data do
  desc "Scrape salaries off of Spotrac.com"

  task :offense => :environment do
    FantasyData::ImportService.import_offense_files
  end

  task :defense => :environment do
    FantasyData::ImportService.import_defensive_files
  end


end
