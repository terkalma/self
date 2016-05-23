ActionMailer::Base.smtp_settings = {
    address: Figaro.env.SMTP_SERVER,
    port: 587,
    enable_starttls_auto: true
}

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default charset: 'utf-8'
