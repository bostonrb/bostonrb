require 'spec_helper'

describe Event do
  it { should validate_presence_of :location }
  it { should validate_presence_of :event_type }
  it { should validate_presence_of :date }
  it { should validate_presence_of :start_at }
  it { should validate_presence_of :end_at }
  it { should validate_presence_of :rsvp_url }

  it { should belong_to(:location).with_foreign_key('location_id') }
  it { should belong_to(:event_type).with_foreign_key('event_type_id') }
end
