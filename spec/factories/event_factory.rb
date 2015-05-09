FactoryGirl.define do
  factory :event do
    hours 8
    minutes 0
    worked_at { Date.today }

    # preferably provide these as parameters
    user
    project
  end
end