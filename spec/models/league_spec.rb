require 'spec_helper'

describe League do
  before(:each) do
    @league = build(:league)
  end

  it "Factory generates valid League" do
    @league.should be_valid
  end

  describe "League model is valid" do
    it "Should have a name" do
      @league.name = nil
      @league.should_not be_valid
    end

    it "Name has to be 5 characters at least" do
      @league.name = "1234"
      @league.should_not be_valid
    end

    it "Name can't be more than 20 characters" do
      @league.name = "123456789012345678901"
      @league.should_not be_valid
    end

    it "Should have a tagline" do
      @league.tagline = nil
      @league.should_not be_valid
    end
  end

  describe "functionality" do
   it "Forum Topics are ordered by updated date" do
     topics_ordered = @league.forum_topics.order('updated_at desc')
     expect(topics_ordered).to match_array(@league.forum_topics)
   end
  end
end
