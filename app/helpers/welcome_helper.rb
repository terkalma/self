module WelcomeHelper
  def events_title
    "Work on #{@date.strftime('%a, %b %d %Y')}, Total: #{hours_worked}"
  end

  def event_duration(event)
    distance_of_time_in_words event.duration
  end

  def project_name(event)
    event.project ? event.project.name : 'Project N/A'
  end

  def events_at(date=@date)
    current_user.events.at date
  end

  def hours_worked(date=@date)
    distance_of_time_in_words events_at(date).total
  end
end
