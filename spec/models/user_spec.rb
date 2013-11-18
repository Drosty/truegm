require 'spec_helper'

describe User do
  before(:each) do
    @user = build(:user)
  end

  it "Factory Generates Valid Model" do
    @user.should be_valid
  end
  
  it "can only be on one team per league" do
  
  end
end
