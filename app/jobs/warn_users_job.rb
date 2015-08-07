class WarnUsersJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    today = Date.today

    User.find_each do |user|
      UserMailer.warning(user.id).deliver_later if user.projects.any? && user.events.at(today).empty?
    end
  end
end
