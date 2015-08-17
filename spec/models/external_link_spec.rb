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

require 'spec_helper'

describe ExternalLink do

  before(:each) do
    @link = build(:external_link)
  end

  it "Factory Generates Valid Model" do
    @link.should be_valid
  end

  describe "The Link must be correct" do
    it "Must have a Url" do
      @link.url = nil
      lambda {@link.save!}.should raise_error
    end
    
    it "On Save adds http:// if not present" do
      @link.url = "google.com"
      @link.save!
      @link.url.should == "http://google.com"
    end

    it "On Save don't change if http link" do
      @link.url = "http://google.com"
      @link.save!
      @link.url.should == "http://google.com"
    end

    it "On Save don't change if https link" do
      @link.url = "https://google.com"
      @link.save!
      @link.url.should == "https://google.com"
    end
  end

  it "must have a name" do
    @link.name = nil
    @link.should_not be_valid
  end

  it "must have a user associated" do
    @link.user = nil
    @link.should_not be_valid
  end
end
