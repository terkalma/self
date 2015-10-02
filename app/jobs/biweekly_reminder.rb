class BiweeklyReminder < ActiveJob::Base
  queue_as :default

  def perform(*args)
    from = Date.today.last_week.beginning_of_week.to_s
    to = Date.today.to_s

    User.where(admin: false).find_each do |user|
      UserMailer.report(user.id, from, to).deliver_later
    end
  end
end