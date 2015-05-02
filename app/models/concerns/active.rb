require 'active_support/concern'

module Active
  extend ActiveSupport::Concern

  included do
    scope :active_at, ->(t) do
      where('available_from <= ?', t).where('available_until IS NULL OR available_until > ?', t).order :available_from
    end
    scope :active, -> { active_at Date.today }
  end
end