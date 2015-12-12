module EventsHelper
  def validation_class(event, column)
    (event && event.errors[column].present?) ? 'invalid' : ''
  end

  def validation_message(event, column)
    label = <<-HTML
      <label class="validation error">
        #{event && event.errors[column].join('. ')}
      </label>
    HTML

    label.html_safe
  end
end
