class EventType < ActiveRecord::Base
  attr_accessible :name
  validates_presence_of :name
  has_many :events,
    inverse_of: :event_type
end
