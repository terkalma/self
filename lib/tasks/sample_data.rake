
desc 'Clears the database and seeds it with random development data'
namespace :dev do
  task populate: :environment do
    abort 'Go Away! You\'re not in development environment.' unless Rails.env.development?

    Rake::Task['db:reset'].execute

    FactoryGirl.create_list :project_with_users, 10, user_count: 5
    User.all.each { |u| FactoryGirl.create :active_rate, payable: u }

    User.includes(:projects).all.each do |user|
      (5.days.ago.to_date..5.days.from_now.to_date).each do |date|
        FactoryGirl.create :event, user: user, project: user.projects.first, worked_at: date
      end
    end
  end
end
