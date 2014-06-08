namespace :generate do
  desc "Generate Fake Data when needed"

  task :fake_salaries => :environment do
    service = FantasyData::DataGeneratorService.new
    service.generate_fake_salaries()
  end

  task :year_of_fake_stats => :environment do
    service = FantasyData::DataGeneratorService.new
    service.generate_year_of_fake_data()
  end

end
