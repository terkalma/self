class Project < ActiveRecord::Base
  include FriendlyId
  friendly_id :name, :use => [:slugged]

  validates_presence_of :name
  validates_uniqueness_of :name

  has_many :user_projects, dependent: :destroy
  has_many :events, dependent: :nullify
  has_many :users, through: :user_projects

  def to_keen
    {
        name: name
    }
  end
end
