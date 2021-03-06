namespace :import do
  desc "Import Data from Fantasy Data Live data Stream"

  task :yearly_stats, [:year] => :environment do |t, args|
    args.with_defaults(:year => 2014)

    matchups = Fantasydata.schedule_by_year args[:year]

    (1..17).each do |week|
      puts "processing week: #{week}"
      home_teams = matchups.select { |s| s.season  == args[:year].to_i && s.week == week }.map(&:home_team)

      home_teams.each do |team|
        puts "processing week: #{week} Home Team: #{team}"
        get_import_service().import_weekly_stats(args[:year], week, team)
      end
    end
  end

  task :weekly_stats, [:week, :year] => :environment do |t, args|
    args.with_defaults(:week => 1, :year => 2014)

    matchups = Fantasydata.schedule_by_year args[:year]
    home_teams = matchups.select { |s| s.season  == args[:year].to_i && s.week == args[:week].to_i }.map(&:home_team)

    home_teams.each do |team|
      puts "processing week: #{args[:week].to_i} Home Team: #{team}"
      get_import_service().import_weekly_stats(args[:year].to_i, args[:week].to_i, team)
    end
  end

  task :nfl_teams => :environment do
    get_import_service().import_nfl_team_data
  end

  task :nfl_players => :environment do
    get_import_service().import_nfl_player_data
  end

  task :nfl_schedule => :environment do
    get_import_service().import_nfl_schedule
  end

  def get_import_service
    Fantasydata.configure do |config|
      config.api_key = ENV['fantasy_data_api_key']
    end
    FantasyData::ImportService.new
  end

end
