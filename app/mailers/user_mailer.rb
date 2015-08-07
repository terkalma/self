class UserMailer < ApplicationMailer
  default from: "no-reply@#{Figaro.env.app_title}.com"

  def warning(user_id)
    @user = User.find user_id
    
    mail to: @user.email, subject: "Just a reminder (#{Time.now.asctime})"
  end
end
