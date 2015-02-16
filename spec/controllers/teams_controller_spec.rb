require 'spec_helper'

describe TeamsController do
  include Warden::Test::Helpers

  before (:each) do
    Warden.test_mode!
  end

  after (:each) do
    Warden.test_reset!
  end

  describe "Regular user - Visit Team Page" do
    before(:each) do
      @one_team_user = create(:user_with_one_team)
      sign_in(@one_team_user)
    end

  end
end
