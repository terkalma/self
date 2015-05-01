FactoryGirl.define do
  factory :project do
    name { Faker::Name.last_name }
  end

  factory :user_project do
    user
    project
  end
end