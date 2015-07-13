class EventsController < ApplicationController
  respond_to :html
  respond_to :js, only: [:create, :update]

  after_filter :publish_event_to_keen

  def create
    @event = Event.new permitted_params
    @success = @event.save
    @date = @event.worked_at
    respond_with @event, location: -> { root_path(date: permitted_params[:worked_at]) }
  end

  def update
    @event = Event.find params[:id]
    @success = @event.update permitted_params
    @date = @event.worked_at
    respond_with @event, location: -> { root_path(date: permitted_params[:worked_at]) }
  end

  def destroy
    @event = Event.find params[:id]
    @event.destroy
    flash[:notice] = 'Event successfully removed'
  rescue
    flash[:alert] = 'Unable to remove event!'
  ensure
    redirect_to root_path(date: @event.worked_at)
  end

  private
  def permitted_params
    params.require(:event).permit :hours, :minutes, :description, :project_id, :user_id, :worked_at, :ot
  end

  def publish_event_to_keen
    if @event && (@event.persisted? || @event.destroyed?)
      publish_keen collection: :events, event: @event.to_keen( action: params[:action])
    end
  rescue
    # don't care about issues with +Keen+
  end
end
