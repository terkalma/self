class Rate < ActiveRecord::Base
  include Active

  belongs_to :payable, polymorphic: true, inverse_of: :rates

  validates_presence_of :hourly_rate, :hourly_rate_ot, :available_from, :payable
  validates_numericality_of :hourly_rate, greater_than: 0
  validates_numericality_of :hourly_rate_ot, greater_than_or_equal_to: :hourly_rate
  validate :ensure_latest_available_from, :ensure_available_until_after_available_from
  before_update :update_available_until
  before_create :update_available_until
  after_commit :update_events
  #
  # returns the +user+ for a +rate+. If the payable is not a user,
  # then it's the +payable+'s responsibility to return a user
  #
  def user
    @user ||= if payable.kind_of?(User)
                payable
              else
                payable.user
              end
  end

  private
  def update_events
    user.events.between(available_from, available_until).each(&:save)
    true
  end

  def ensure_latest_available_from
    rate = Rate.where(payable: payable).active.first

    if rate && available_from && available_from < rate.available_from
      errors.add :available_from, "There's a rate set for a later time: #{rate.available_from.asctime}"
    end
  end

  def ensure_available_until_after_available_from
    if available_until && available_from >= available_until
      errors.add :available_until, 'must be later than available from'
    end
  end

  def update_available_until
    Rate.where(payable: payable)
        .where('available_from < ? AND (available_until IS NULL OR available_until > ?)',available_from, available_from)
        .update_all available_until: available_from

    rate = Rate.where(payable: payable).where('available_from > ?', available_from).order(:available_from).first

    self.available_until = rate.available_from if rate.present?

    true
  end
end