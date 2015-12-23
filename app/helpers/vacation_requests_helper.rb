module VacationRequestsHelper
  def vacation_class(vacation_request)
    if vacation_request.approved?
      'btn-success'
    elsif vacation_request.pending?
      'btn-warning'
    elsif vacation_request.declined?
      'btn-danger'
    end
  end

  def validation_class(vacation_request, column)
    (vacation_request && vacation_request.errors[column].present?) ? 'invalid' : ''
  end

  def validation_message(vacation_request, column)
    label = <<-HTML
      <label class="validation error">
        #{ vacation_request && vacation_request.errors[column].join('. ')}
      </label>
    HTML

    label.html_safe
  end
end
