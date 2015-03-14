class User < ActiveRecord::Base
  has_many :user_projects
  has_many :projects, through: :user_projects

  devise :database_authenticatable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  validate :has_company_email_address

  def self.from_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.password = Devise.friendly_token[0,20]
    end
  end

  private
  def has_company_email_address
    address = Mail::Address.new email
    unless address.domain == "#{Figaro.env.email_domain}.com"
      errors.add(:email, "You're not welcomed here with a #{address.domain} email domain.")
    end
  end
end
