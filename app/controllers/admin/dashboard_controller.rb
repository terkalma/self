module Admin
  class DashboardController < BaseController

    add_breadcrumb 'Admin', :admin_dashboard_path

    def index
      if VacationRequest.pending.any?
        @vacation_requests = VacationRequest.pending.includes :user
        flash.now[:partial] = 'admin/dashboard/pending_vacations'
      end
    end
  end
end