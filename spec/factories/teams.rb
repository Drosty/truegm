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
