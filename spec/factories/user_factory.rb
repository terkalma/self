FactoryGirl.define do
  factory :user_without_an_email, class: User do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    password { Faker::Internet.password }

    trait :random_email do
      email { Faker::Internet.email }
    end

    trait :company_email do
      email do
        email = Faker::Internet.email
        "#{email.split('@').first}@#{Figaro.env.email_domain}.com"
      end
    end

    factory :user, traits: [ :company_email ]
    factory :user_with_random_email, traits: [ :random_email ]
  end
end
