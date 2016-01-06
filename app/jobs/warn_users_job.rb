class WarnUsersJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    today = Date.today

    User.find_each do |user|
      if user.projects.any? && user.events.at(today).empty? && !user.on_vacation?
        UserMailer.warning(user.id).deliver_later
      end
    end
  end
end
