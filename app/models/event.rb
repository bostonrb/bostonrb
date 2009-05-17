class Event < ActiveRecord::Base

  #RECURRING = {
    #:hackfest => { :title    => "Hackfest",
                   #:location => "41 Winter Street, Boston, MA, 02108",
                   #:when     => { :first => :tuesday,
                                  #:at    => 7.pm,
                                  #:each  => :month } }
  #}

  has_markup :description,
    :required   => true,
    :cache_html => true

  validates_presence_of :date, :title, :location

  before_save      :geocode_location
  acts_as_mappable :default_units => :miles

  def self.new_recurring(event)
    new :title    => RECURRING[event].title,
        :location => RECURRING[event].location,
        :date     => Recurrence.next(RECURRING[event][:when])
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
  named_scope :special, :conditions => { :recurring => false }

  def self.next_five_special
    self.next(5).special
  end

  def self.next_four_recurring
    self.next(4).recurring
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
