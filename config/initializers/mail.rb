ActionMailer::Base.smtp_settings = {
    address: 'smtp.mandrillapp.com',
    port: 587,
    enable_starttls_auto: true,
    user_name: Figaro.env.MANDRILL_USERNAME,
    password: Figaro.env.MANDRILL_PASSWORD
}

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default charset: 'utf-8'
