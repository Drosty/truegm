FactoryGirl.define do
  factory :stat do
    year 2014
    week 1

    factory :stat_qb_good do
      passing_yards 300
      passing_touchdowns 3
      passing_interceptions 0
      rushing_yards 0
      rushing_touchdowns 0
      receptions 0
      receiving_yards 0
      receiving_touchdowns 0
      fumbles_lost 0
    end

    factory :stat_qb_bad do
      passing_yards 150
      passing_touchdowns 1
      passing_interceptions 2
      rushing_yards -10
      rushing_touchdowns 0
      receptions 0
      receiving_yards 0
      receiving_touchdowns 0
      fumbles_lost 1
    end

    factory :stat_rb_good do
      passing_yards 0
      passing_touchdowns 0
      passing_interceptions 0
      rushing_yards 130
      rushing_touchdowns 2
      receptions 4
      receiving_yards 40
      receiving_touchdowns 1
      fumbles_lost 0
    end

    factory :stat_rb_bad do
      passing_yards 0
      passing_touchdowns 0
      passing_interceptions 0
      rushing_yards 35
      rushing_touchdowns 0
      receptions 1
      receiving_yards 7
      receiving_touchdowns 0
      fumbles_lost 1
    end

    factory :stat_wr_good do
      passing_yards 0
      passing_touchdowns 0
      passing_interceptions 0
      rushing_yards 18
      rushing_touchdowns 0
      receptions 12
      receiving_yards 137
      receiving_touchdowns 2
      fumbles_lost 0
    end

    factory :stat_wr_bad do
      passing_yards 0
      passing_touchdowns 0
      passing_interceptions 0
      rushing_yards -4
      rushing_touchdowns 0
      receptions 2
      receiving_yards 7
      receiving_touchdowns 0
      fumbles_lost 1
    end

    factory :kicking_stat do
    end

    factory :defense_stat do
      tfl 8
      defensive_interceptions 4
      fumbles_recovered 3
      safties 2
      defensive_tds 1
      points_allowed 11
    end

  end

end
