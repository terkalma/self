class FeedbacksController < ApplicationController
  # POST /feedbacks
  # POST /feedbacks.json
  def create
    @feedback = current_user.feedbacks.new(feedback_params)
    @success = @feedback.save

    respond_to do |format|
      format.js {}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feedback
      @feedback = Feedback.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feedback_params
      params.require(:feedback).permit(:comment)
    end
end
