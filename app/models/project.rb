class Project < ActiveRecord::Base
  has_markup :description, :cache_html => true

  named_scope :all, :order => 'name asc'
  
  validates_presence_of :name
  validates_format_of :homepage_url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/i
  validates_format_of :feed_url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/i, :allow_nil => true, :allow_blank => true
end
