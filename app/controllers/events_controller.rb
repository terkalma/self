class EventsController < ApplicationController

  def create
    begin
      Event.create permitted_params.merge user_id: current_user.id
      flash[:notice] = 'Event created successfully!'
    rescue => e
      flash[:alert] = "Something went wrong... (#{e.message})"
    end

    redirect_to root_path
  end

  def permitted_params
    params.require(:event).permit(:hours, :minutes, :description, :project_id)
  end
end
