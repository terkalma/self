FactoryGirl.define do

  trait :active do
    available_from { 10.day.ago.to_date }
    available_until { 10.day.from_now.to_date }
  end

  trait :expired do
    available_from { 20.days.ago.to_date }
    available_until { 10.day.ago.to_date }
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

    factory :active_rate, traits: [:active]
    factory :active_rate_for_user, traits: [ :rate_for_user, :active ]
    factory :active_rate_for_user_project, traits: [ :rate_for_user_project, :active ]
    factory :expired_rate_for_user, traits: [ :rate_for_user, :expired ]
    factory :expired_rate_for_user_project, traits: [ :rate_for_user_project, :expired ]
  end
end