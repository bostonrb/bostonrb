class Presentation < ActiveRecord::Base
  has_markup :description, :cache_html => true
  belongs_to :user

  def to_s
    title
  end

  def self.featured
    self.random
  end

  def presenter
    user || other_speakers
  end

  def self.latest
    first :order => 'updated_at desc'
  end
end
