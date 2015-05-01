require 'active_support/concern'

module Payable
  extend ActiveSupport::Concern

  included do
    has_many :rates, as: :payable
  end

  def current_rate
    rates.active.first
  end

  #
  # @param time [Time] time when the we're curios about the rate
  #
  def rate_at(time)
    rates.active_at(time).first
  end

  def payable_at?(time)
    rate_at(time).present?
  end

  def payable?
    current_rate.present?
  end
end