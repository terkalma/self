module Admin
  class EventsController < BaseController
    def event_table
      user = User.find params[:id]

      respond_to do |format|
        format.json do
          collection = user.events.joins('LEFT JOIN projects ON projects.id = events.project_id')
          render json: EventDataTable.new(view: view_context, relation: collection)
        end
      end
    end
  end
end