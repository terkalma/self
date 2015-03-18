module WelcomeHelper
  def title
    "Work on #{@date.strftime('%a %b %d %Y')}"
  end

  def hours_worked
    distance_of_time_in_words @events.total
  end

  def event_duration(event)
    distance_of_time_in_words event.duration
  end

  def project_name(event)
    event.project ? event.project.name : 'Project N/A'
  end
end
