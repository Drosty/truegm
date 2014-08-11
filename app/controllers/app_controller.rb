class AppController < ApplicationController
  respond_to :html
  before_filter :ensure_user_logged_in

  def index
  end
end
