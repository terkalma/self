ActionMailer::Base.smtp_settings = {
    address: Figaro.env.SMTP_SERVER,
    port: 25,
    enable_starttls_auto: false
}

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default charset: 'utf-8'