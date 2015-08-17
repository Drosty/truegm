# == Schema Information
#
# Table name: nfl_teams
#
#  id          :integer          not null, primary key
#  created_at  :datetime
#  updated_at  :datetime
#  spotrac_url :string
#  code        :string
#  full_name   :string
#  short_name  :string
#  bye_week    :integer
#

FactoryGirl.define do
  factory :nfl_team do
    code "ABC"
    full_name "Full Football Team Name"
    short_name "Short Name"
  end
end
