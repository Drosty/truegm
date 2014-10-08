# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player_salary_information do
    fantasy_data_id 1
    player_name "MyString"
    position "MyString"
    team "MyString"
    salary 1
    projection 1.5
  end
end
