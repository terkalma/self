require 'rails_helper'

RSpec.describe VacationLimit, type: :model do
  let(:date) do
    Time.new 2015, 05, 11 # this is a monday.
  end

  let(:user) do
    FactoryGirl.create :user
  end

  it 'should allow 10 free days/year by default for a user' do
    expect(user.vacation_limit).to eq 10
  end

  it 'should be able to adjust limit for a user' do
    user.vacation_limits.create year: date.year, limit: 15
    expect(user.vacation_limit).to eq 15
  end

  it 'should be able to adjust limit for an arbitrary year' do
    user.vacation_limits.create year: date.year + 1, limit: 20
    expect(user.vacation_limit).to eq 10
    expect(user.vacation_limit_at date.year + 1).to eq 20
  end
end
