FactoryGirl.define do
  trait :approved do
    status :approved
  end

  trait :vacation_period do
    transient do
      from 2.days.ago
      to 2.days.from_now
    end

    vacation_from { from }
    vacation_to { to }
  end

  factory :vacation_request do

    reason { 'Vacation Has Been Requested!' }
    user
    approved
    vacation_period
  end
end