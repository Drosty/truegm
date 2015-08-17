# == Schema Information
#
# Table name: teams
#
#  id           :integer          not null, primary key
#  name         :string
#  tagline      :string
#  league_id    :integer
#  user_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#  total_salary :integer          default(0)
#  invite_code  :string
#

FactoryGirl.define do
  sequence :name do |n|
    "First#{n} Last#{n}"
  end

  sequence :invite_code do |n|
    "ABC#{n}XYZ#{n}"
  end

  factory :team do
    name
    tagline "MyString"
    league { FactoryGirl.create(:league) }
    user { FactoryGirl.create(:user) }
    total_salary 1000000
    invite_code
  end
end
