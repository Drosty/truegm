namespace :spotrac do
  desc "Scrape salaries off of Spotrac.com"

  task :scrape => :environment do
    Spotrac::SpotracService.scrape_site
  end

  task :teams => :environment do
    Spotrac::SpotracService.process_spotrac_team_data
  end

  task :players => :environment do
    Spotrac::SpotracService.process_spotrac_player_data
  end

  task :salaries => :environment do
    Spotrac::SpotracService.process_spotrac_salary_data
  end
end
