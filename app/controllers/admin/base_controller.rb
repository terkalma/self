module Admin
  class BaseController < ApplicationController
    before_action :authenticate_admin
    layout 'layouts/admin'

    def authenticate_admin
      unless current_user.admin?
        redirect_to root_path(date: @date)
      end
    end

    def current_admin
      current_user
    end
    helper_method :current_admin
  end
end