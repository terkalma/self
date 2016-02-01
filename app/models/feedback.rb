class Feedback < ActiveRecord::Base
  belongs_to :user

  enum status: [ :pending, :in_progress, :resolved, :dismissed ].map {|status| [status, status.to_s]}.to_h

  validates_presence_of :comment
end
