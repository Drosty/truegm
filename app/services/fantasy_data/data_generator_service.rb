module FantasyData
  class DataGeneratorService

    def generate_fake_salaries
      NflPlayer.all.each do |player|
        player.salary = rand(250000..8000000).to_s
        player.save
      end

      # save all teams so the team salary is updated
      Team.all.each do |team|
        team.save
      end
    end

    def generate_year_of_fake_data
      year = 2013

      NflPlayer.all.each do |player|
        generate_stats_for_player(player, year)
      end
    end


private

    def generate_stats_for_player player, year
      17.times do |week|
        generate_stat_for_player(player, year, week+1)
      end
    end

    def generate_stat_for_player player, year, week
      stat = Stat.find_or_create_by(nfl_player_id: player.id, year: year, week: week)
      update_stat_with_data_by_position(stat, player.position)
    end

    def update_stat_with_data_by_position stat, position
      position = position.upcase

      stat.played = rand(0..1)
      stat.started = rand(0..1)

      if position == "QB"
          stat.passing_yards = rand(150..400)
          stat.passing_touchdowns = rand(1..4)
          stat.interceptions = rand(0..3)
          stat.rushing_yards = rand(-15..25)
          stat.rushing_touchdowns = 0
          stat.fumbles_lost = rand(0..1)
          stat.passing_completions = rand(20..35)
          stat.passing_attempts = rand(stat.passing_completions..stat.passing_completions+20)
          stat.qb_rating = 100
          stat.rushing_attempts = rand(1..8)
          stat.fumbles = rand(0..2)
          stat.long_run = 0

      elsif position == "RB"
          stat.rushing_yards = rand(-10..180)
          stat.rushing_touchdowns = rand(0..3)
          stat.receptions = rand(0..8)
          stat.receiving_yards = rand(0..40) if stat.receptions > 0
          stat.receiving_yards = 0 if stat.receptions == 0
          stat.receiving_touchdowns = rand(0..1) if stat.receptions > 0
          stat.receiving_touchdowns = 0 if stat.receptions == 0
          stat.fumbles_lost = rand(0..1)
          stat.rushing_attempts = rand(5..25)
          stat.fumbles = rand(0..2)
          stat.receiving_long = 0

      elsif position == "WR" || position == "TE"
          stat.receptions = rand(0..14)
          stat.receiving_yards = rand(-1..184)
          stat.receiving_touchdowns = rand(0..2)
          stat.fumbles_lost = rand(0..1)
          stat.receiving_long = 0

      elsif position == "DEF"
          stat.tfl = rand(0..7)
          stat.sacks = rand(0..4)
          stat.qbhits = rand(0..5)
          stat.defensive_interceptions = rand(0..1)
          stat.fumbles_recovered = rand(0..2)
          stat.safties = rand(0..1)
          stat.defensive_tds = rand(0..1)
          stat.return_tds = rand(0..1)
          stat.points_allowed = rand(2..42)
      end

      stat.passing_percentage  = stat.passing_completions / stat.passing_attempts if !stat.passing_attempts.nil? && stat.passing_attempts > 0
      stat.average_pass_yards = stat.passing_yards / stat.passing_attempts if !stat.passing_attempts.nil? && stat.passing_attempts > 0
      stat.receiving_average = stat.receiving_yards / stat.receptions if !stat.receptions.nil? && stat.receptions > 0
      stat.rushing_average = stat.rushing_yards / stat.rushing_attempts if !stat.rushing_attempts.nil? && stat.rushing_attempts > 0

      stat.save
    end

  end

end
