class Event < ActiveRecord::Base
  belongs_to :user_project

  scope :at, ->(d) { where(worked_at: d) }
end
