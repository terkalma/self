class Project < ActiveRecord::Base
  include FriendlyId
  friendly_id :name, :use => [:slugged]

  has_many :user_projects, dependent: :destroy
  has_many :events, dependent: :nullify
  has_many :users, through: :user_projects
end
