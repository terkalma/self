ActionMailer::Base.smtp_settings = {
    address: Figaro.env.smtp_address,
    port: Figaro.env.smtp_port,
    enable_starttls_auto: true,
    user_name: Figaro.env.smtp_username,
    password: Figaro.env.smtp_password
}

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default charset: 'utf-8'