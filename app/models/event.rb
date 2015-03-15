class Event < ActiveRecord::Base
  belongs_to :user_project
  include Aggregate
end
