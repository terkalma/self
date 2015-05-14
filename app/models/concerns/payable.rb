require 'active_support/concern'

module Payable
  extend ActiveSupport::Concern

  included do
    has_many :rates, as: :payable, dependent: :destroy, inverse_of: :payable
  end

  def current_rate
    case self
    when UserProject
      rates.active.first || user.current_rate
    when User
      rates.active.first
    else
      raise NotImplementedError("#{self.class} does not have a rate logic")
    end
  end

  #
  # @param time [Date] time when the we're curios about the rate
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