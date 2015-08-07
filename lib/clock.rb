require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'

module Clockwork
  handler do |job, time|
    puts "Running #{job}, at #{time}"
    "#{job}".constantize.perform_later
  end

  every 1.day, 'WarnUsersJob', at: '19:00', tz: 'CET'

end
