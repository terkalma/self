require 'rails_helper'

RSpec.describe Project, type: :model do
  subject { FactoryGirl.build(:project) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }
end
