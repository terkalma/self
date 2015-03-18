class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  include Aggregate

  def duration
    hours.hours + minutes.minutes
  end
end
