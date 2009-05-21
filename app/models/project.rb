class Project < ActiveRecord::Base
  has_markup :description, :cache_html => true

  named_scope :all, :order => 'name asc'

  validates_presence_of :name
  validates_url_format_of :homepage_url, :message => "is invalid"

  def to_s
    name
  end

  def self.featured
    first :order => "rand()"
  end
end
