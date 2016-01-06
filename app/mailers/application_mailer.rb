class ApplicationMailer < ActionMailer::Base
  default from: "no-reply@#{Figaro.env.app_title}.com"
  default bcc: Figaro.env.cc_addresses.try(:split, ',')

end
