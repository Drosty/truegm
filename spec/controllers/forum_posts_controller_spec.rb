require 'spec_helper'

describe ForumPostsController do
  include Warden::Test::Helpers

  before (:each) do
    Warden.test_mode!
  end

  after (:each) do
    Warden.test_reset!
  end

  def valid_attributes
    attributes_for(:forum_post)
  end
  
  describe "index normal user" do
    before(:each) do
      @one_team_user = build(:user_with_one_team)
      login(@one_team_user)
    end
  end
end
