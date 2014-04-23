require 'spec_helper'

describe LeaguesController do
  include Warden::Test::Helpers

  before (:each) do
    Warden.test_mode!
  end

  after (:each) do
    Warden.test_reset!
  end

  def valid_attributes
    attributes_for(:league)
  end

  describe "User with no team" do
    before(:each) do
      user = create(:user)
      login(user)
    end

    it "can get to league index page" do
      visit leagues_path
      page.should have_content(I18n.t('leagues.header'))
    end
  end
  
end
