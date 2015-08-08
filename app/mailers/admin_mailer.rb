class AdminMailer < ApplicationMailer
  def vacation_request(vr_id)
    @vacation_request = VacationRequest.find vr_id

    mail to: Figaro.env.email_address_vacation, subject: 'Vacation has been requested!'
  end
end
