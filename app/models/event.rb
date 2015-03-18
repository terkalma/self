class Event < ActiveRecord::Base
  belongs_to :user_project
  include Aggregate

  def project
    user_project.project
  end

  def duration
    hours.hours + minutes.minutes
  end
end
