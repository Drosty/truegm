namespace :generate do
  desc "Scrape salaries off of Spotrac.com"

  task :fake_salaries => :environment do
    service = FantasyData::DataGeneratorService.new
    service.generate_fake_salaries()
  end

  task :year_of_fake_stats => :environment do
    service = FantasyData::DataGeneratorService.new
    service.generate_year_of_fake_data()
  end

end
