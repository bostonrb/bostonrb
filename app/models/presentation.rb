class Presentation < ActiveRecord::Base

  belongs_to :user

  def to_s
    title
  end

  def self.featured
    first :order => "rand()"
  end

  def presenter
    user || other_speakers
  end

end
