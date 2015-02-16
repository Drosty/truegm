# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :nfl_matchup do
    import_game_id 1
    week 1
    year 1
    game_date "2014-05-30 15:25:11"
    away_team { FactoryGirl.create(:nfl_team, code: "AWAY") }
    home_team { FactoryGirl.create(:nfl_team, code: "HOME") }
    tv_station "MyString"
  end
end
