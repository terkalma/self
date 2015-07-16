class User < ActiveRecord::Base
  has_many :user_projects, dependent: :destroy
  has_many :projects, through: :user_projects
  has_many :events, dependent: :destroy

  include Oauth
  include Payable
  include Vacation

  devise :database_authenticatable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  validate :has_company_email_address?
  validates_numericality_of :vacation_limit, greater_than_or_equal_to: 0
  before_save :set_admin_flag

  has_associated_audits

  def name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def to_keen
    {
      name: name,
      email: email,
      created_at: created_at,
      ip: current_sign_in_ip
    }
  end

  private
  def set_admin_flag
    admins = Figaro.env.admins.split(',').map &:strip
    address = Mail::Address.new email

    self.admin = admins.include? address.local

    self
  end

  def has_company_email_address?
    address = Mail::Address.new email
    unless address.domain == "#{Figaro.env.email_domain}.com"
      errors.add(:email, "You're not welcome here with a #{address.domain} email domain.")
    end
  end
end
