class Job < ActiveRecord::Base
  validates_presence_of :location, :organization, :title
  has_markup :description, :required => true, :cache_html => true

  named_scope :recent, lambda {{
        :conditions => ['updated_at > ?', 1.month.ago],
        :order      => 'updated_at desc'
  }}
  named_scope :old, lambda {{
    :conditions => ['updated_at <= ?', 1.month.ago],
    :order      => 'updated_at desc'
  }}
end
