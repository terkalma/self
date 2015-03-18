class Project < ActiveRecord::Base
  include FriendlyId
  friendly_id :name, :use => [:slugged]

  has_many :user_projects
  has_many :events
  has_many :users, through: :user_projects
end
