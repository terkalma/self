class UserMailer < ApplicationMailer
  layout 'mailer'

  def warning(user_id)
    @user = User.find user_id
    @preheader = "I know you're busy, but don't forget to log your hours."

    mail to: @user.email, subject: "Just a reminder (#{Time.now.asctime})"
  end

  def report(user_id, from, to)
    @user = User.find user_id
    @from = Date.parse from
    @to = Date.parse to
    @preheader = "Get Paid - Report!"

    mail to: @user.email, subject: 'Report'
  end
end
