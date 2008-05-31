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
  validates_presence_of :date, :title, :description

  acts_as_mappable :default_units => :miles
  before_save :geocode_location

  has_finder :upcoming, :conditions => ['date > ?', DateTime.now],
                        :order      => 'date desc'

  acts_as_paranoid
  
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
