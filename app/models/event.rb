class Event < ActiveRecord::Base
  attr_accessible :event_type_id, :location_id, :date, :start_at, :end_at, :rsvp_url
  validates_presence_of :event_type_id
  validates_presence_of :location_id
  validates_presence_of :date
  validates_presence_of :start_at
  validates_presence_of :end_at
  validates_presence_of :rsvp_url

  belongs_to :event_type,
    foreign_key: 'event_type_id',
    inverse_of: :events
  belongs_to :location,
    foreign_key: 'location_id',
    inverse_of: :events
end
