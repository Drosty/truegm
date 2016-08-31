class AppController < ApplicationController
  before_filter :ensure_user_logged_in

  def index
  end
end
