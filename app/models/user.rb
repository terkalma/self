class User < ActiveRecord::Base
  include Oauth

  has_many :user_projects
  has_many :projects, through: :user_projects
  has_many :events

  devise :database_authenticatable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  validate :has_company_email_address
  before_save :set_admin_flag

  def name
    "#{first_name.capitalize}, #{last_name.capitalize}"
  end

  private
  def set_admin_flag
    admins = Figaro.env.admins.split(',').map &:strip
    address = Mail::Address.new email

    self.admin = admins.include? address.local

    self
  end

  def has_company_email_address
    address = Mail::Address.new email
    unless address.domain == "#{Figaro.env.email_domain}.com"
      errors.add(:email, "You're not welcome here with a #{address.domain} email domain.")
    end
  end
end
