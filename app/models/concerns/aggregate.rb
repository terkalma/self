require 'active_support/concern'

module Aggregate
  extend ActiveSupport::Concern

  included do
    scope :at, ->(d) { where(worked_at: d) }
  end

  class_methods do
    def total
      sum(:hours).hours + sum(:minutes).minutes
    end
  end
end