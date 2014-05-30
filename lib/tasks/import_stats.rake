namespace :import do
  desc "Scrape salaries off of Spotrac.com"

  task :offense => :environment do
    FantasyData::ImportService.import_offense_files
  end

  task :defense => :environment do
    FantasyData::ImportService.import_defensive_files
  end

  task :nfl_teams => :environment do
    get_import_service().import_nfl_team_data
  end

  task :nfl_players => :environment do
    get_import_service().import_nfl_player_data nil
  end

  def get_import_service
    FantasyData::ImportService.new(FantasyFootballNerdParty.new)
  end

end
