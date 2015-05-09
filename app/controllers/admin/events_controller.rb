module Admin
  class EventsController < BaseController
    def event_table
      user = User.find params[:id]
      collection = user.events.joins('LEFT JOIN projects ON projects.id = events.project_id')

      respond_to do |format|
        format.json do
          render json: EventDataTable.new(view: view_context, relation: collection)
        end
        format.html { redirect_to admin_user_path(params[:id]) }
      end
    end
  end
end