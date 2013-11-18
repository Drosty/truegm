FactoryGirl.define do
  sequence :first_name do |n|
    "First#{n}"
  end

  sequence :last_name do |n|
    "Last#{n}"
  end

  factory :nfl_player do
    nfl_team { FactoryGirl.create(:nfl_team) }
    first_name
    last_name
    position "NA"
    salary 100000
  end

  trait :qb do
    position "QB"
  end

  trait :rb do
    position "RB"
  end

  trait :wr do
    position "WR"
  end

  trait :te do
    position "TE"
  end

  trait :def do
    position "D"
  end

  trait :pk do
    position "K"
  end

end
