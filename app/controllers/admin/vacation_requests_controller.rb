module Admin
  class VacationRequestsController < BaseController
    include DateParser
    around_filter :evaluate_vacation_request, only: [:accept, :decline]
    before_filter :initialize_holiday, only: [:holiday, :index]

    add_breadcrumb 'Admin', :admin_dashboard_path
    add_breadcrumb 'Vacations', :admin_vacation_requests_path

    def index
      @collection = User.vacation_alert(from: from_date, to: to_date, key: :name)
    end

    def holiday
      @holiday.create_events if @holiday.valid?

      respond_to do |format|
        format.js {}
        format.html { redirect_to action: :index }
      end
    end

    def accept
      @vacation_request.approved_by! current_admin

      redirect_to edit_admin_user_path(@vacation_request.user_id)
    end

    def decline
      @vacation_request.declined_by! current_admin

      redirect_to edit_admin_user_path(@vacation_request.user_id)
    end

    def evaluate_vacation_request
      @vacation_request = VacationRequest.find params[:vacation_id]

      begin
        yield
        AdminMailer.vacation_request_evaluated(@vacation_request.id).deliver_later
        flash[:notice] = 'Vacation request successfully evaluated!'
      rescue Exception => e
        flash[:alert] = 'Unable to evaluate vacation request!'
      end
    end

    private
    def initialize_holiday
      if params[:holiday_params]
        @holiday = Admin::Holiday.new params[:holiday_params]
      else
        @holiday = Admin::Holiday.new from_date: from_date, to_date: to_date, message: params[:message]
      end
    end
  end
end