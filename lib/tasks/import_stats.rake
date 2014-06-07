namespace :import do
  desc "Import Data from Fantasy Football Nerd API"

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

  def get_import_service
    FantasyData::ImportService.new(FantasyFootballNerdParty.new)
  end

end
