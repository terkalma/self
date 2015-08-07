class VacationLimit < ActiveRecord::Base
  belongs_to :user

  scope :at, -> (year){ where year: year }
end
