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
end
