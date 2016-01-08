class FeedbackDataTable < BaseDataTable

  def initialize(view:, relation: nil)
    super view: view, relation:  relation || Feedback.joins(:user)
  end

  private
  def map_resource(feedback)
    [
      feedback.comment,
      feedback.user.email
    ]
  end

  def header
    %w[comment users.email]
  end

  def default_sort_column
    'users.email'
  end
end
