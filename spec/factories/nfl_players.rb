# == Schema Information
#
# Table name: nfl_players
#
#  id              :integer          not null, primary key
#  nfl_team_id     :integer
#  first_name      :string
#  last_name       :string
#  position        :string
#  salary          :integer
#  created_at      :datetime
#  updated_at      :datetime
#  spotrac_url     :string
#  full_name       :string
#  jersey          :string
#  height          :string
#  weight          :string
#  dob             :datetime
#  college         :string
#  active          :boolean
#  current_status  :string
#  depth_order     :integer
#  experience      :integer
#  photo_url       :string
#  fantasy_data_id :integer
#

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
    position Position::QUARTERBACK
  end

  trait :rb do
    position Position::RUNNINGBACK
  end

  trait :wr do
    position Position::WIDERECEIVER
  end

  trait :te do
    position Position::TIGHTEND
  end

  trait :def do
    position Position::DEFENSE
  end

  trait :pk do
    position Position::KICKER
  end

end
