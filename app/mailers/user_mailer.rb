class UserMailer < ApplicationMailer
  default from: "no-reply@#{Figaro.env.app_title}.com"

  def warning(user_id)
    @user = User.find user_id
    
    mail to: @user.email, subject: "Just a reminder (#{Time.now.asctime})"
  end

  def report(user_id, from, to)
    @user = User.find user_id
    @from = Date.parse from
    @to = Date.parse to

    mail to: @user.email, subject: 'Report - Someone pliiiiz help me with email templates and FE'
  end
end
