module A
  def approved!
    return if approved?

    transaction do
      super
      paid? && (vacation_from..vacation_to).each do |worked_at|

        if (1..5).include? worked_at.wday
          Event.create(
              worked_at: worked_at,
              user_id: user_id,
              hours: 8,
              description: "#{human_type} vacation",
              gefroren: true
          )
        end
      end
    end
  end
end

class VacationRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :admin, class_name: 'User'

  enum status: { pending: 0, approved: 1, declined: 2 }

  scope :at, ->(d) { where('vacation_from <= ?', d).where('vacation_to >= ?', d) }
  scope :active_at, ->(d) { approved.at(d) }
  scope :pending_at, -> (d) { pending.at(d) }
  scope :active, -> { active_at(Date.today) }
  scope :this_year, -> { where('vacation_from >= ?', 0.hours.ago.beginning_of_year).order('vacation_from DESC') }
  scope :not_declined, -> { where.not status: statuses[:declined] }
  scope :paid, -> { where paid: true }
  scope :unpaid, -> { where paid: false }

  include VacationEvaluation
  prepend A

  before_validation :compute_length
  validates_presence_of :vacation_to, :vacation_from
  validates_presence_of :reason
  validate :not_empty, :non_overlapping
  validate :vacation_limit, :vacation_dates_in_same_year, if: :paid?

  def human_type
    paid? ? 'Paid' : 'Unpaid'
  end

  def overlapping_error
    "This request is overlapping with an existing one (#{vacation_from}-#{vacation_to})"
  end

  def as_json(*args)
    {
        created_at: created_at,
        updated_at: updated_at,
        approved_by: admin.try(:name),
        length: length,
        vacation_from: vacation_from,
        vacation_to: vacation_to,
        reason: reason,
        status: status,
        url: Rails.application.routes.url_helpers.edit_vacation_request_path(id),
        vacation_url: Rails.application.routes.url_helpers.vacation_request_path(id),
        id: id
    }
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
      return false
    end
  end

  def vacation_dates_in_same_year
    if length > 0 && vacation_from.year != vacation_to.year
      errors.add :vacation_to, 'The two dates are not in the same year.'\
       'Please split the request as they belong to different reporting periods'
    end
  end

  def vacation_limit
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

    if r = overlap_from_right(requests)
      errors.add :vacation_from, r.overlapping_error
    end

    if r = overlap_from_left(requests)
      errors.add :vacation_to, r.overlapping_error
    end

    if r = contained(requests)
      errors.add :vacation_to, r.overlapping_error
      errors.add :vacation_from, r.overlapping_error
    end
  end

  #
  # Checks if +self+ overlaps from the right at least 1 of the requests from +scope+
  # [a, b] right overlaps [c, d] if a >= c && a =< d
  #
  # returns first object which fulfills the condition
  #
  def overlap_from_right(scope)
    scope.where('vacation_from <= ?', vacation_from).where('vacation_to >= ?', vacation_from).first
  end

  #
  # Checks if +self+ overlaps from the left at least 1 of the requests from +scope+
  # [a, b] right overlaps [c, d] if b >= c && b =< d
  #
  # returns first object which fulfills the condition
  #
  def overlap_from_left(scope)
    scope.where('vacation_from <= ?', vacation_to).where('vacation_to >= ?', vacation_to).first
  end

  #
  # Checks if +self+ contains at least 1 of the requests from +scope+
  # [a, b] right overlaps [c, d] if a =< c && b >= d
  #
  # returns first object which fulfills the condition
  #
  def contained(scope)
    scope.where('vacation_from >= ?', vacation_from).where('vacation_to <= ?', vacation_to).first
  end
end