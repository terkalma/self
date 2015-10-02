require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'

module Clockwork
  handler do |job, time|
    puts "Running #{job}, at #{time}"
    "#{job}".constantize.perform_later
  end

  every 1.day, 'WarnUsersJob', at: '19:00', tz: 'CET', if: lambda { |t| (1..5).include? t.strftime('%w').to_i }
  every 2.weeks, 'BiweeklyReminder', at: 'Friday 16:20', tz: 'CET'
end
