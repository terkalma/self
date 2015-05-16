class EventsController < ApplicationController
  respond_to :html, :js

  after_filter :publish_event_to_keen

  def create
    @event = Event.new permitted_params
    @success = @event.save
    respond_with @event, location: -> { root_path(date: permitted_params[:worked_at]) }
  end

  def update
    @event = Event.find params[:id]
    byebug
    @success = @event.update permitted_params
    respond_with @event, location: -> { root_path(date: permitted_params[:worked_at]) }
  end

  private
  def permitted_params
    params.require(:event).permit :hours, :minutes, :description, :project_id, :user_id, :worked_at, :ot
  end

  def publish_event_to_keen
    if @event && @event.persisted?
      publish_keen collection: :events, event: @event.to_keen( ation: params[:action])
    end
  rescue
    # don't care about issues with +Keen+
  end
end
