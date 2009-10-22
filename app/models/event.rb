class Event < ActiveRecord::Base
  include Pacecar

  has_markup :description,
    :required   => true,
    :cache_html => true

  validates_presence_of :date, :title, :location

  before_save      :geocode_location
  acts_as_mappable :default_units => :miles

  def to_s
    title
  end

  def lat_lng_pair
    [lat, lng]
  end

  def geocoded?
    lat && lng
  end

  named_scope :next, lambda {|*args|
    limit = args.first || 1
    { :conditions => ['date > ?', DateTime.now],
      :order      => 'date asc',
      :limit      => limit }
  }

  named_scope :recurring, :conditions => { :recurring => true }
  named_scope :special,   :conditions => { :recurring => false }

  def self.per_page
    8
  end

  def self.paginate_by_date(page)
    by_date(:desc).paginate(:page => page)
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
