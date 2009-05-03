class Event < ActiveRecord::Base

  validates_presence_of :date, :title, :location
  has_markup :description, :required => true, :cache_html => true
  acts_as_mappable :default_units => :miles
  before_save :geocode_location

  named_scope :upcoming, :conditions => ['date > ?', DateTime.now],
                         :order      => 'date asc'
  named_scope :upcoming, lambda {{
                :conditions => ['date > ?', DateTime.now],
                :order      => 'date asc' } }
  named_scope :past, lambda {{:conditions => ['date < ?', DateTime.now],
                        :order      => 'date desc'}}

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
