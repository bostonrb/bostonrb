class App < ActiveRecord::Base
  validates_presence_of :name
  validates_url_format_of :homepage_url, :message => "is invalid"

  named_scope :all, :order => 'name asc'

  def self.featured
    self.random
  end
end
