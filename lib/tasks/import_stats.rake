namespace :import do
  desc "Import Data from Fantasy Football Nerd API"

  task :stats => :environment do
    service = get_import_service()
    # service.import_offense_files
    service.import_defensive_files
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

  task :nfl_bye_weeks => :environment do
    get_import_service().import_nfl_bye_weeks
  end

  def get_import_service
    puts "API KEY: #{ENV["fantasy_data_api_key"]}"
    FantasyData::ImportService.new(FantasyDataParty.new(ENV["fantasy_data_api_key"]))
  end

end
