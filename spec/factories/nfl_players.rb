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

  trait :fa do
    nfl_team nil
  end

  trait :qb do
    position "qb"
  end

  trait :rb do
    position "rb"
  end

  trait :wr do
    position "wr"
  end

  trait :te do
    position "te"
  end

  trait :def do
    position "def"
  end

  trait :pk do
    position "k"
  end

end
