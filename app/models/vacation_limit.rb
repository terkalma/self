class VacationLimit < ActiveRecord::Base
  belongs_to :user

  scope :at, -> (year){ where year: year }

  validates_numericality_of :limit, greater_than_or_equal_to: 0
  validates_numericality_of :limit, smaller_than_or_equal_to: 100
end
