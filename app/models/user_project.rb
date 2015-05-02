class UserProject < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  validates_presence_of :user_id, :project_id

  include Payable

  accepts_nested_attributes_for :rates
end
