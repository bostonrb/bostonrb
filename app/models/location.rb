class Location < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :street
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zipcode

  has_many :events,
    inverse_of: :location
end
