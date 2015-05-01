class UserProject < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  include Payable
end
