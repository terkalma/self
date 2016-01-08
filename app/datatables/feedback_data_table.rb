class FeedbackDataTable < BaseDataTable

  def initialize(view:, relation: nil)
    super view: view, relation:  relation || Feedback
  end

  private
  def map_resource(feedback)
    [
      feedback.comment,
      feedback.user_id
    ]
  end

  def header
    %w[user_id comment]
  end

  def default_sort_column
    'user_id'
  end

end
