module WelcomeHelper
  def title
    "Work on #{@date.strftime('%a %b %d %Y')}"
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

  def remove_event_options
    {
        method: :delete,
        data: { confirm: 'Are you sure?' },
        role: 'button',
        class: 'btn btn-default',
        style: 'float: right;'
    }
  end
end
