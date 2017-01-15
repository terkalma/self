class ApplicationMailer < ActionMailer::Base
  default from: Figaro.env.mail_from
  default bcc: Figaro.env.cc_addresses.try(:split, ',')
end
