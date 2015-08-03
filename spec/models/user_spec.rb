require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should not be valid without a valid domain' do
    expect(FactoryGirl.build :user_with_random_email).not_to be_valid
  end

  it 'should be valid with a company email domain' do
    expect(FactoryGirl.build :user).to be_valid
  end
end
