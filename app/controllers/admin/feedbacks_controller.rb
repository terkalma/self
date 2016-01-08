module Admin
  class FeedbacksController < BaseController

    respond_to :html

    add_breadcrumb 'Admin', :admin_dashboard_path
    add_breadcrumb 'Feedbacks', :admin_feedbacks_path

    def index
      respond_to do |format|
        format.json do
          render json: FeedbackDataTable.new(view: view_context)
        end
        format.html { }
      end
    end
  end
end
