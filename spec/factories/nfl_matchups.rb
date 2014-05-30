# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :nfl_matchup do
    import_game_id 1
    week 1
    year 1
    game_date "2014-05-30 15:25:11"
    away_team_id 1
    home_team_id 1
    tv_station "MyString"
  end
end
