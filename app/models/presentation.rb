class Presentation < ActiveRecord::Base

  named_scope :all, :order => 'updated_at desc'

  def self.latest
    first :order => 'updated_at desc'
  end
  named_scope :all_except_latest, { :order => 'updated_at desc', :offset => 1 }

end
