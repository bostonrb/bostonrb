class Event < ActiveRecord::Base
  attr_accessible :event_type
  validates_presence_of :event_type
  attr_accessible :location
  validates_presence_of :location
  attr_accessible :date
  validates_presence_of :date
  attr_accessible :start_at
  validates_presence_of :start_at
  attr_accessible :end_at
  validates_presence_of :end_at
  attr_accessible :rsvp_url
  validates_presence_of :rsvp_url

  belongs_to :event_type,
    foreign_key: 'event_type_id',
    inverse_of: :events
  belongs_to :location,
    foreign_key: 'location_id',
    inverse_of: :events
end
