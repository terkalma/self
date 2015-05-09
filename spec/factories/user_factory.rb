FactoryGirl.define do
  trait :random_email do
    email { Faker::Internet.email }
  end

  trait :company_email do
    email do
      email = Faker::Internet.email
      "#{email.split('@').first}@#{Figaro.env.email_domain}.com"
    end
  end

  trait :full_name do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end

  factory :user_without_an_email, class: User do
    transient do
      set_admin false
    end

    password { Faker::Internet.password }
    full_name

    # sneaky admin flag update.
    after :create do |user, evaluator|
      user.update_column :admin, evaluator.set_admin
    end

    factory :user_with_random_email, traits: [ :random_email ]
  end

  factory :user, parent: :user_without_an_email do
    company_email

    factory :user_with_projects do
      transient do
        project_count 5
      end

      after :create do |user, evaluator|
        create_list :user_project, evaluator.project_count, user: user
      end
    end
  end
end
