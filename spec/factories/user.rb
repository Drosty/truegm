FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@gmail.com"
  end

  factory :user do
    email
    password "qwerty1234!!!"

    factory :user_with_one_team do
      after_build { |user|
        user.teams << FactoryGirl.build(:team, :user => user) 
      }

      after_create { |user|
        user.teams << FactoryGirl.create(:team, :user => user) 
      }
    end 

    factory :user_with_two_teams do
      after_build { |user|
        user.teams { FactoryGirl.build_list(:team, 2, :user => user) }
      }

      after_create { |user|
        user.teams << FactoryGirl.create_list(:team, 2, :user => user) 
      }
    end
  end

  trait :admin do
    is_admin true
  end
end