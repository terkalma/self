class EventDataTable < BaseDataTable
  def initialize(view:, relation: nil)
    super view: view, relation:  relation || Event.joins('LEFT JOIN projects ON projects.id = events.project_id')
  end

  private
  def header
    %w[projects.name amount hours minutes worked_at]
  end

  def map_resource(event)
    [
      event.project.try(:name) || 'Project N/A',
      event.amount,
      event.hours,
      event.minutes,
      event.worked_at.to_s,
      event.description
    ]
  end

  def default_sort_column
    'worked_at'
  end
end
