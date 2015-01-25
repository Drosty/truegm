namespace :import do
  desc "Import Data from Fantasy Football Nerd API"

  task :weekly_stats, [:week, :year] => :environment do |t, args|
    args.with_defaults(:week => 1, :year => 2014)
    puts "#{args[:year]} - #{args[:week]}"
    get_import_service().import_weekly_stats(args[:year], args[:week])
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
    puts "API KEY: #{ENV["fantasy_data_api_key"]}"
    FantasyData::ImportService.new(FantasyDataParty.new(ENV["fantasy_data_api_key"]))
  end

end
