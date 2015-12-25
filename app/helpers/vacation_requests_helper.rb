module VacationRequestsHelper
  def vacation_class(vacation_request)
    "btn-#{vacation_status_map vacation_request.status}"
  end

  def vacation_status_map(status)
    case status
    when 'approved'
      'success'
    when 'declined'
      'danger'
    when 'pending'
      'warning'
    else
      'default'
    end
  end

  def vacation_alert_map(stss)
    keys = VacationRequest.statuses.keys
    stss && stss.split(/\s/).reduce('') { |clss, s| "#{clss} #{vacation_status_map keys[s.to_i]}" }
  end
end
