# == Schema Information
#
# Table name: forum_topics
#
#  id               :integer          not null, primary key
#  league_id        :integer
#  name             :string
#  description      :text
#  created_at       :datetime
#  updated_at       :datetime
#  forumposts_count :integer          default(0)
#  user_id          :integer
#

FactoryGirl.define do
  factory :forum_topic do
    user { FactoryGirl.create(:user) }
    league { FactoryGirl.create(:league) }
    name "Forum Topic"
    description "Topic about some really awesome thing"
    forumposts_count 0
  end
end
