
desc 'Clears the database and seeds it with random development data'
namespace :dev do
  task populate: :environment do
    abort 'Go Away! You\'re not in development environment.' unless Rails.env.development?

    Rake::Task['db:reset'].execute
    FactoryGirl.create_list :project_with_users, 10, user_count: 5
  end
end
