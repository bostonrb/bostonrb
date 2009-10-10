class Job < ActiveRecord::Base
  include Pacecar

  validates_presence_of :location, :organization, :title
  has_markup :description, :required => true, :cache_html => true

  def self.featured
    self.random
  end
end
