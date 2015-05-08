FactoryGirl.define do
  factory :project do
    name { Faker::Name.last_name }

    factory :project_with_users do
      ignore do
        user_count 10
      end

      after :create do |project, evaluator|
        evaluator.user_count.times do
          create :user_project, project: project
        end
      end
    end
  end

  factory :user_project do
    user
    project
  end
end