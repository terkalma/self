class VacationRequestsController < ApplicationController
  respond_to :html
  respond_to :js, only: [:create, :update]

  def index
    respond_to do |format|
      format.json do
        render json: {
                      vacation_requests: VacationRequest.statuses.keys.map do |status|
                          { status =>  current_user.vacation_requests.this_year.send(status) }
                      end.reduce(:merge)
               }
      end

      format.html { redirect_to root_path }
    end
  end

  def create
    @vacation_request = VacationRequest.new create_vacation_params
    @success = @vacation_request.save
    AdminMailer.vacation_request(@vacation_request.id).deliver_later if @success
    respond_with @vacation_request, location: -> { root_path date: @date }
  end

  def edit
    @vacation_request = VacationRequest.find params[:id]
    render layout: false
  end

  def update
    @vacation_request = VacationRequest.find params[:id]
    @success = @vacation_request.update create_vacation_params
    AdminMailer.vacation_request(@vacation_request.id).deliver_later if @success
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
    params.require(:vacation_request).permit :vacation_from, :vacation_to, :paid, :user_id, :reason
  end
end
