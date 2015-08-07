require 'active_support/concern'

module Vacation
  extend ActiveSupport::Concern

  included do
    has_many :vacation_requests, dependent: :destroy
    has_many :vacation_limits, dependent: :destroy
  end

  class_methods do
    def vacationing
      self.where id: VacationRequest.active.pluck(:user_id).uniq
    end
  end

  def vacation_limit
    vacation_limit_at Date.today.year
  end

  def vacation_limit_at(year)
    vacation_limits.at(year).first.try(:limit) || self['vacation_limit']
  end

  def on_vacation?
    vacation_requests.active.count > 0
  end

  def vacation_days_left
    vacation_limit - days_on_vacation_this_year
  end

  #
  # Only counting payed days.
  #
  def days_on_vacation_this_year
    from = 0.hour.ago.beginning_of_year
    to = 0.hour.ago.end_of_year

    vacation_requests.approved.paid.where('vacation_from >= ?', from).where('vacation_to <= ?', to).pluck(:length).sum
  end
end