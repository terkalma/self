module Admin
  class DashboardController < BaseController

    add_breadcrumb 'Admin', :admin_dashboard_path

    def index
    end
  end
end