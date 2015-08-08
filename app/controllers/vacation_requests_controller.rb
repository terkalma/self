class VacationRequestsController < ApplicationController
  respond_to :html
  respond_to :js, only: [:create]

  def create
    @vacation_request = VacationRequest.new create_vacation_params
    @success = @vacation_request.save
    AdminMailer.vacation_request(@vacation_request.id).deliver_later
    respond_with @vacation_request, location: -> { root_path date: @date }
  end

  def destroy
    @vacation_request = VacationRequest.find params[:id]
    @vacation_request.destroy
    flash[:notice] = 'Vacation request successfully removed'
  rescue
    flash[:alert] = 'Unable to remove vacation request!'
  ensure
    redirect_to root_path date: @date
  end

  private
  def create_vacation_params
    params.require(:vacation_request).permit :vacation_from, :vacation_to, :paid, :user_id
  end
end
