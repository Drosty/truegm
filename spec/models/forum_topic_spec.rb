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

require 'spec_helper'

describe ForumTopic do
  before(:each) do
    # @valid_attributes = { }
  end

  it "should create a new instance given valid attributes" do
    # ForumTopic.create!(@valid_attributes)
  end
end
