class VacationRequestsController < ApplicationController
  respond_to :html
  respond_to :js, only: [:create, :update]

  before_action :load_request, only: [:edit, :update, :destroy]

  def index
    respond_to do |format|
      format.json do
        render json: {
                      vacation_requests: VacationRequest.statuses.keys.map do |status|
                          { status =>  scope.this_year.send(status) }
                      end.reduce(:merge)
               }
      end

      format.html { redirect_to root_path }
    end
  end

  def create
    @vacation_request = scope.new vacation_params
    @success = @vacation_request.save
    AdminMailer.vacation_request(@vacation_request.id).deliver_later if @success
    respond_with @vacation_request, location: -> { root_path date: @date }
  end

  def edit
    render layout: false
  end

  def update
    @success = @vacation_request.update vacation_params
    AdminMailer.vacation_request(@vacation_request.id).deliver_later if @success
    respond_with @vacation_request, location: -> { root_path date: @date }
  end

  def destroy
    @vacation_request.destroy
    flash[:notice] = 'Vacation request successfully removed'
  rescue
    flash[:alert] = 'Unable to remove vacation request!'
  ensure
    redirect_to root_path date: @date
  end

  private
  def scope
    current_user.vacation_requests
  end

  def load_request
    @vacation_request = scope.find params[:id]
  end

  def vacation_params
    params.require(:vacation_request).permit :vacation_from, :vacation_to, :paid, :reason
  end
end
