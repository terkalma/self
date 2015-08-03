require 'rails_helper'

RSpec.describe VacationRequest, type: :model do
  let(:date) do
    Time.new 2015, 05, 11 # this is a monday.
  end

  describe :approved do
    let :user do
      user = FactoryGirl.create :user
      # creating a vacation request until friday.
      FactoryGirl.create :vacation_request, from: date, to: date + 4.days, user: user
      user
    end

    it 'should count days spent this year on vacation' do
      allow(Time).to receive(:now) { date + 1.month }
      expect(user.days_on_vacation_this_year).to eq 5
    end

    it 'should not count days spent last year on vacation' do
      allow(Time).to receive(:now) { date + 1.year }
      expect(user.days_on_vacation_this_year).to eq 0
    end
  end

  describe :exclude_weekends do
    let :user do
      user = FactoryGirl.create :user
      # creating a vacation request for 2 weeks.
      FactoryGirl.create :vacation_request, from: date, to: date + 13.days, user: user
      user
    end

    it 'should not count weekends' do
      allow(Time).to receive(:now) { date + 1.month }
      expect(user.days_on_vacation_this_year).to eq 10
    end
  end

  describe :declined do
    let :user do
      user = FactoryGirl.create :user
      FactoryGirl.create :vacation_request, from: date, to: date + 4.days, user: user, status: :declined
      user
    end

    it 'should not count days for declined vacation request' do
      allow(Time).to receive(:now) { date + 1.month }
      expect(user.days_on_vacation_this_year).to eq 0
    end
  end

  it 'should allow 10 free days/year by default for a user' do
    user = FactoryGirl.create :user
    expect(user.vacation_limit).to eq 10
  end

  it 'should not be allowed to request more days than available' do
    user = FactoryGirl.create :user
    vacation_request = FactoryGirl.build :vacation_request, from: date, to: date + 20.days, user: user

    expect(vacation_request).not_to be_valid
  end

  describe :overlap do
    let :user do
      FactoryGirl.create :user
    end

    it 'should not be valid (partial)' do
      allow(Time).to receive(:now) { date + 1.month }

      FactoryGirl.create :vacation_request, from: date, to: date + 4.days, user: user, status: :pending
      v2 = FactoryGirl.build :vacation_request, from: date + 2, to: date + 6.days, user: user, status: :pending

      expect(v2).not_to be_valid
    end

    it 'should not be valid (full)' do
      allow(Time).to receive(:now) { date + 1.month }

      FactoryGirl.create :vacation_request, from: date, to: date + 4.days, user: user, status: :pending
      v2 = FactoryGirl.build :vacation_request, from: date, to: date + 4.days, user: user, status: :pending

      expect(v2).not_to be_valid
    end
  end
end
