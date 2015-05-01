FactoryGirl.define do

  trait :active do
    available_from { 1.day.ago }
    available_until { 1.day.from_now }
  end

  trait :expired do
    available_from { 2.days.ago }
    available_until { 1.day.ago }
  end

  factory :rate do
    hourly_rate 10
    hourly_rate_ot 15

    trait :rate_for_user_project do
      association :payable, factory: :user_project
    end

    trait :rate_for_user do
      association :payable, factory: :user
    end

    factory :active_rate_for_user, traits: [ :rate_for_user, :active ]
    factory :active_rate_for_user_project, traits: [ :rate_for_user_project, :active ]
    factory :expired_rate_for_user, traits: [ :rate_for_user, :expired ]
    factory :expired_rate_for_user_project, traits: [ :rate_for_user_project, :expired ]
  end
end