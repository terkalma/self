Warden::Manager.before_logout do |user|
  Keen.publish :logouts, user.to_keen
end