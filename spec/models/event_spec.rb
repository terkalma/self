require 'rails_helper'

RSpec.describe Event, type: :model do
  let :user do
    FactoryGirl.create :user
  end

  it 'should not be longer than 12h' do
    expect(FactoryGirl.build :event, hours: 12, minutes: 15, user: user).not_to be_valid
  end

  it 'should not be able to work 24h in a day' do
    FactoryGirl.create :event, hours: 12, user: user
    event = FactoryGirl.build :event, hours: 12, user: user

    expect(event).not_to be_valid
  end

  it 'should not be able to exceed 24h in a day' do
    FactoryGirl.create :event, hours: 12, user: user
    FactoryGirl.create :event, hours: 8, user: user
    event = FactoryGirl.build :event, hours: 8, user: user

    expect(event).not_to be_valid
  end
end
