module Admin
  class FeedbacksController < BaseController

    respond_to :html

    add_breadcrumb 'Admin', :admin_dashboard_path
    add_breadcrumb 'Feedbacks', :admin_feedbacks_path

    def index
      relation = params[:statusFilter] == 'all' ? Feedback.joins(:user) : Feedback.joins(:user).where(status: params[:statusFilter])

      respond_to do |format|
        format.json do
          render json: FeedbackDataTable.new(view: view_context, relation: relation)
        end
        format.html { }
      end
    end

    def dismissed
      @feedback = Feedback.find params[:id]
      @feedback.dismissed!

      redirect_to admin_feedbacks_path
    end

    def in_progress
      @feedback = Feedback.find params[:id]
      @feedback.in_progress!

      redirect_to admin_feedbacks_path
    end

    def resolved
      @feedback = Feedback.find params[:id]
      @feedback.resolved!

      redirect_to admin_feedbacks_path
    end
  end
end
