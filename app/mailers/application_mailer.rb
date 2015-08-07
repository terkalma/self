class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@#{Figaro.env.app_title}.com"
  layout 'mailer'
end
