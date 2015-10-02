class Project < ActiveRecord::Base
  include FriendlyId
  friendly_id :name, :use => [:slugged]

  validates_presence_of :name
  validates_uniqueness_of :name

  has_associated_audits

  has_many :user_projects, dependent: :destroy
  has_many :events, dependent: :nullify
  has_many :users, through: :user_projects

  def to_keen
    {
        name: name
    }
  end

  class << self
    def events_for_projects(user:, date:)
      user.projects.map do |project|
        events = user.events.at(date).where(project_id: project.id).map do |e|
          {
              duration: e.duration / 3600.0,
              description: e.description,
              total: e.amount
          }
        end

        { project.name => events }
      end.reduce(:merge)
    end
  end
end
