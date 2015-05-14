module Admin
  class ReportsController < BaseController
    before_filter :set_dates

    def index
      rel = User.joins(:events).group('users.id').where('events.worked_at >= ? AND events.worked_at <= ?', @from, @to)

      respond_to do |format|
        format.json do
          render json: UserReportDataTable.new(view: view_context, relation: rel)
        end
        format.html { redirect_to admin_dashboard_path }
      end
    end

    private
    def set_dates
      @from = Date.parse(params[:from]) rescue Date.new
      @to = Date.parse(params[:to]) rescue Date.tomorrow
    end
  end
end
