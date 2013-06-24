class MonthlyMeeting < ActiveRecord::Base
  validates :url, :presence => true
  validates :url, :format => { :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/i, :allow_blank => true, :message => 'invalid URL' }
  attr_accessible :url
end
