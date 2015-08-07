class VacationRequest < ActiveRecord::Base
  belongs_to :user

  enum status: { pending: 0, approved: 1, declined: 2 }

  scope :active_at, ->(d) { approved.where('vacation_from >= ?', d).where('vacation_to <= ?', d) }
  scope :active, -> { active_at(Date.today) }
  scope :this_year, -> { where('vacation_from >= ?', 0.hours.ago.beginning_of_year).order('vacation_from DESC') }
  scope :not_declined, -> { where.not status: statuses[:declined] }
  scope :paid, -> { where paid: true }
  scope :unpaid, -> { where paid: false }

  before_validation :compute_length
  validates_presence_of :vacation_to, :vacation_from
  validate :not_empty, :vacation_limit, :vacation_dates_in_same_year, :non_overlapping

  def unpaid?
    !paid?
  end

  def human_type
    paid? ? 'Paid' : 'Unpaid'
  end

  private
  def compute_length
    return true unless vacation_from && vacation_to
    self.length = (vacation_from..vacation_to).reject { |date| [0, 6, 7].include? date.wday }.count
  end

  def not_empty
    if length == 0
      error_msg = 'The period requested does not contain any working days'
      errors.add :vacation_from, error_msg
      errors.add :vacation_to, error_msg
    end
  end

  def vacation_dates_in_same_year
    return true if unpaid?

    unless vacation_from.year == vacation_to.year
      errors.add :vacation_to, 'The two dates are not in the same year.'\
       'Please split the request as they belong to different reporting periods'
    end
  end

  def vacation_limit
    return true if unpaid? # no limit validation for unpaid vacations.

    available = user.vacation_limit - user.days_on_vacation_this_year
    if length > available
      error_msg = "The vacation length exceeds the number of requestable days(#{available})"
      errors.add :vacation_to, error_msg
      errors.add :vacation_from, error_msg
    end
  end

  def non_overlapping
    requests = user.vacation_requests.not_declined
    requests = requests.where.not(id: self.id) if persisted?

    error_msg = ->(r) { "This request is overlapping with an existing one (#{r.vacation_from}-#{r.vacation_to})" }

    if r = requests.where('vacation_from <= ?', vacation_from).where('vacation_to >= ?', vacation_from).first
      errors.add :vacation_from, error_msg.call(r)
    end

    if r = requests.where('vacation_from <= ?', vacation_to).where('vacation_to >= ?', vacation_to).first
      errors.add :vacation_to, error_msg.call(r)
    end

    if r = requests.where('vacation_from >= ?', vacation_from).where('vacation_to <= ?', vacation_to).first
      errors.add :vacation_to, error_msg.call(r)
      errors.add :vacation_from, error_msg.call(r)
    end
  end
end