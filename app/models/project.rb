class Project < ActiveRecord::Base
  has_markup :description, :cache_html => true

  named_scope :all, :order => 'name asc'
end
