module Admin
  class VacationRequestsController < BaseController

    around_filter :evaluate_vacation_request, only: [:accept, :decline]

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
  end
end