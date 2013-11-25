require 'spec_helper'

describe ForumTopic do
  before(:each) do
    @ft = build(:forum_topic)
  end

  it "Factory generates valid ForumTopic" do
    @ft.should be_valid
  end

  describe "Model is valid" do
    it "Has a name" do
      @ft.name = nil
      @ft.should_not be_valid
    end

    it "Has a description" do
      @ft.description = nil
      @ft.should_not be_valid
    end

    it "Belongs to a league" do
      @ft.league = nil
      @ft.should_not be_valid
    end
  end
end
