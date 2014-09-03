module Admin
  class BaseController < ApplicationController
    before_filter :verify_admin

  private

  end

end
