# == Schema Information
#
# Table name: invites
#
#  id           :integer          not null, primary key
#  email        :string
#  team_id      :integer
#  sender_id    :integer
#  recipient_id :integer
#  token        :string
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe Invite do
  before(:each) do
    @valid_attributes = { }
  end

  it "should create a new instance given valid attributes" do
    Invite.create!(@valid_attributes)
  end
end
    
