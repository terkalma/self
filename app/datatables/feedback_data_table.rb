class FeedbackDataTable < BaseDataTable
  delegate :dismissed_admin_feedback_path, :resolved_admin_feedback_path, :in_progress_admin_feedback_path, to: :@view

  def initialize(view:, relation: nil)
    super view: view, relation:  relation || Feedback.joins(:user)
  end

  private
  def map_resource(feedback)
    [
      feedback.comment,
      feedback.user.email,
      feedback.status.to_s.humanize
    ] + build_buttons(feedback)
  end

  def header
    %w[comment users.email status]
  end

  def default_sort_column
    'users.email'
  end

  def build_buttons(feedback)
    first_button = (%w(dismissed resolved).include? feedback.status) ? '' : button_to('Dismiss', dismissed_admin_feedback_path(feedback), method: :patch )
    second_button = case feedback.status
                      when 'pending'
                        button_to('In progress', in_progress_admin_feedback_path(feedback), method: :patch )
                      when 'in_progress'
                        button_to('Resolved', resolved_admin_feedback_path(feedback), method: :patch )
                      else
                        ''
                    end
    [first_button, second_button]
  end
end