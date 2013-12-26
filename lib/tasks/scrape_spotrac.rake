namespace :spotrac do
  desc "Scrape salaries off of Spotrac.com"

  task :scrape => :environment do
    puts "started"
    puts "User Count: #{User.count}"
  end
end

