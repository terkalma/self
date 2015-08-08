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

  it "should be able to edit event if the total doesn't exceed 24h" do
    FactoryGirl.create :event, hours: 12, user: user
    FactoryGirl.create :event, hours: 8, user: user
    event = FactoryGirl.create :event, hours: 2, user: user

    expect(event).to be_valid

    event.hours = 3
    expect(event).to be_valid

    event.hours = 5
    expect(event).not_to be_valid
  end

  it 'should not be able to edit frozen event' do
    event = FactoryGirl.create :event, hours: 12, user: user
    expect(event).to be_valid

    event.update_column :gefroren, true
    expect(event).not_to be_valid
  end
end
