module Admin
  class BaseController < ApplicationController
    before_filter :verify_admin

  private

    def verify_admin
      redirect_to leagues_path, :alert => 'Unauthorized' unless current_user && current_user.is_admin?
    end

  end

end
