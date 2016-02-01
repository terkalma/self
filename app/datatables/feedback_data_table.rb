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
      feedback.status.to_s.capitalize.sub('_', ' '),
      (%w(dismissed resolved).include? feedback.status) ? '' : button_to('Dismiss', dismissed_admin_feedback_path(feedback), method: :patch ),
      choose_button(feedback)
    ]
  end

  def header
    %w[comment users.email status]
  end

  def default_sort_column
    'users.email'
  end

  def choose_button(feedback)
    case feedback.status
      when 'pending'
        button_to('In progress', in_progress_admin_feedback_path(feedback), method: :patch )
      when 'in_progress'
        button_to('Resolved', resolved_admin_feedback_path(feedback), method: :patch )
      else
        ''
    end
  end
end