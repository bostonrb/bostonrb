class EventType < ActiveRecord::Base
  validates_presence_of :name

  has_many :events,
    inverse_of: :event_type
end
