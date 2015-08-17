# == Schema Information
#
# Table name: external_links
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  name        :string
#  description :text
#  url         :string
#  created_at  :datetime
#  updated_at  :datetime
#

FactoryGirl.define do
  factory :external_link do
    user { FactoryGirl.create(:user) }
    name "MyString"
    description "MyText"
    url "MyString"
  end
end
