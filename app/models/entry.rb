class Entry < ActiveRecord::Base
  include Feedra::Entry
  
  named_scope :recent, lambda { |limit| 
    {
      :limit => limit,
      :order => 'published_at desc, created_at desc'
    }
  }
end
