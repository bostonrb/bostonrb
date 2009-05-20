class Presentation < ActiveRecord::Base

  named_scope :all, :order => 'updated_at desc'

end
