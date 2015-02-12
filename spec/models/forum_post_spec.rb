require 'spec_helper'

describe ForumPost do
  before(:each) do
    @valid_attributes = build(:forum_post).attributes
  end

  it "should create a new instance given valid attributes" do
    ForumPost.create!(@valid_attributes)
  end

  it "will update the updated at date when saved" do
    p = build(:forum_post, updated_at: 10.minutes.ago)
    p.save
    p.updated_at > 1.minutes.ago
  end

end
