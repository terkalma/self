require 'active_support/concern'

module Vacation
  extend ActiveSupport::Concern

  included do
    has_many :vacation_requests
  end

  class_methods do
    def vacationing
      self.where id: VacationRequest.active.pluck(:user_id).uniq
    end
  end

  def on_vacation?
    vacation_requests.active.count > 0
  end

  def vacation_days_left
    vacation_limit - days_on_vacation_this_year
  end

  def days_on_vacation_this_year
    from = 0.hour.ago.beginning_of_year
    to = 0.hour.ago.end_of_year

    VacationRequest.approved.where('vacation_from >= ?', from).where('vacation_to <= ?', to).map(&:length).sum
  end
end