# == Schema Information
# Schema version: 8
#
# Table name: events
#
#  id          :integer         not null, primary key
#  date        :date            
#  event_type  :string(255)     
#  description :text            
#  created_at  :datetime        
#  updated_at  :datetime        
#  location    :string(255)     
#  lng         :float           
#  lat         :float           
#

class Event < ActiveRecord::Base
  EVENT_TYPES = ['Hackfest', 'Meeting', 'Kata']
  
  validates_presence_of :date, :event_type, :description
  validates_inclusion_of :event_type, :in => Event::EVENT_TYPES

  acts_as_mappable :default_units => :miles
  before_save :geocode_location

  has_finder :hackfest, :conditions => ['event_type = ?', 'Hackfest'],
                        :order      => 'date desc'
  has_finder :meeting,  :conditions => ['event_type = ?', 'Meeting'],
                        :order      => 'date desc'
  has_finder :kata,     :conditions => ['event_type = ?', 'Kata'],
                        :order      => 'date desc'
  has_finder :upcoming, :conditions => ['date > ?', DateTime.now],
                        :order      => 'date desc'    
  
  def self.next
    find :first, :conditions => ['date > ?', DateTime.now], :order => 'date asc'
  end
  
  def lat_lng_pair
    [lat, lng]
  end
  
  def geocoded?
    lat && lng
  end
  
  protected
  
    def geocode_location
      geo = GeoKit::Geocoders::MultiGeocoder.geocode(location)
      if geo.success
        self.lat = geo.lat
        self.lng = geo.lng
      end
    end
  
end
