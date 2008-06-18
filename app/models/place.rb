class Place < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :address
  validates_presence_of :description

  has_many :events
end
