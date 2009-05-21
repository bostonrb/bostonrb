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

  def self.latest
    first :order => 'updated_at desc'
  end
  named_scope :all_except_latest, { :order => 'updated_at desc', :offset => 1 }

end
