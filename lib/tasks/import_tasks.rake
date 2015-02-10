namespace :import do
  desc "Import Data from Fantasy Football Nerd API"

  task :yearly_stats, [:year] => :environment do |t, args|
    args.with_defaults(:year => 2014)

    (1..17).each do |week|
      puts "processing week: #{week}"
      get_import_service().import_weekly_stats(args[:year], week)
    end
  end

  task :weekly_stats, [:week, :year] => :environment do |t, args|
    args.with_defaults(:week => 1, :year => 2014)

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
    FantasyData::ImportService.new(FantasyDataParty.new(ENV["fantasy_data_api_key"]))
  end

end
