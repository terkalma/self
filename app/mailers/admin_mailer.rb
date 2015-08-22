class AdminMailer < ApplicationMailer
  def vacation_request(vr_id)
    @vacation_request = VacationRequest.find vr_id

    mail to: Figaro.env.email_address_vacation, subject: 'Vacation has been requested!'
  end

  def vacation_request_evaluated(vr_id)
    @vacation_request = VacationRequest.find vr_id
    @user = VacationRequest.user
    @admin = VacationRequest.admin

    mail to: [Figaro.env.email_address_vacation, @user.email], subject: 'Vacation has been evaluated!'
  end
end
