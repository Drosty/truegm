# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime
#  updated_at             :datetime
#  provider               :string
#  uid                    :string
#  is_admin               :boolean
#  name                   :string
#

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
