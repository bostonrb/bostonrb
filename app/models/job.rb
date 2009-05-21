class Job < ActiveRecord::Base
  validates_presence_of :location, :organization, :title
  has_markup :description, :required => true, :cache_html => true
end
