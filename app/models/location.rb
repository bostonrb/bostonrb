class Location < ActiveRecord::Base
  attr_accessible :name
  validates_presence_of :name
  attr_accessible :street
  validates_presence_of :street
  attr_accessible :city
  validates_presence_of :city
  attr_accessible :state
  validates_presence_of :state
  attr_accessible :zipcode
  validates_presence_of :zipcode
  attr_accessible :time_of_deletion

  has_many :events,
    inverse_of: :location

  def self.available
    where(:time_of_deletion => nil)
  end
end
