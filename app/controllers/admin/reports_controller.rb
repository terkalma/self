module Admin
  class ReportsController < BaseController
    before_filter :set_dates

    def index
      relation = Event.between(@from, @to).joins(:user).group('users.id')

      respond_to do |format|
        format.json do
          render json: UserReportDataTable.new(view: view_context, relation: relation)
        end
        format.html { redirect_to admin_dashboard_path }
        format.xls { @data = ReportSheet.new(from: @from, to: @to, search_query: params[:search_query]) }
      end
    end

    private
    def set_dates
      @from = Date.parse(params[:from]) rescue Date.new
      @to = Date.parse(params[:to]) rescue Date.tomorrow
    end
  end
end
