class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :project, dependent: :nullify

  include Aggregate

  def duration
    hours.hours + minutes.minutes
  end
end
