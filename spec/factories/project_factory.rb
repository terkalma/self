FactoryGirl.define do
  factory :project do
    name { Faker::Name.last_name }

    factory :project_with_users do
      transient do
        user_count 10
      end

      after :create do |project, evaluator|
        create_list :user_project, evaluator.user_count, project: project
      end
    end
  end

  factory :user_project do
    user
    project
  end
end