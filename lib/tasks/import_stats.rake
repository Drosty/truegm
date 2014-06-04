namespace :import do
  desc "Scrape salaries off of Spotrac.com"

  task :stats => :environment do
    get_import_service().import_stats
  end

  task :nfl_teams => :environment do
    get_import_service().import_nfl_team_data
  end

  task :nfl_players => :environment do
    get_import_service().import_nfl_player_data nil
  end

  task :nfl_schedule => :environment do
    get_import_service().import_nfl_schedule
  end

  task :generate_fake_salaries => :environment do
    NflPlayer.all.each do |player|
      player.salary = rand(250000..8000000).to_s
      player.save
    end

    # save all teams so the team salary is updated
    Team.all.each do |team|
      team.save
    end
  end

  def get_import_service
    FantasyData::ImportService.new(FantasyFootballNerdParty.new)
  end

end
