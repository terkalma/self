require 'rails_helper'

RSpec.describe Rate, type: :model do
  it 'can be added to a User' do
    rate = FactoryGirl.create :active_rate_for_user

    expect(rate.payable.kind_of? User).to be_truthy

    # should be active rate and the +User+ should be payable
    expect(rate.payable.payable?).to be_truthy
  end

  it 'can be added to a UserProject' do
    rate = FactoryGirl.create :active_rate_for_user_project

    expect(rate.payable.kind_of? UserProject).to be_truthy

    # should be active rate and the +UserProject+ should be payable
    expect(rate.payable.payable?).to be_truthy
  end

  it 'should contain positive rates' do
    expect(FactoryGirl.build :rate, hourly_rate: -5).to_not be_valid
    expect(FactoryGirl.build :rate, hourly_rate: 0).to_not be_valid
  end

  it 'should not be valid if rate > ot rate' do
    expect(FactoryGirl.build :rate, hourly_rate: 5, hourly_rate_ot: 4).not_to be_valid
  end

  it 'should expire old rates, once a new one is added' do
    rate = FactoryGirl.create :active_rate_for_user

    FactoryGirl.create :rate, available_from: 1.hour.ago, payable: rate.payable

    expect(rate.reload.available_until.past?).to be_truthy
  end

  it 'should not allow the creation of a rate with earlier available_from than the latest on' do
    rate = FactoryGirl.create :active_rate_for_user

    expect(FactoryGirl.build :rate, available_from: 3.days.ago, payable: rate.payable).not_to be_valid
  end

  it 'should validate presence of rates' do
    should validate_presence_of(:hourly_rate)
    should validate_presence_of(:hourly_rate_ot)
  end
end
