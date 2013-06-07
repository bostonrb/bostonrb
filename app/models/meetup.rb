class Meetup < ActiveRecord::Base
  validates :meeting_url, :project_night_url, :presence => true
  validates :meeting_url, :project_night_url, :format => { :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/i, :allow_blank => true, :message => 'invalid URL' }
  attr_accessible :meeting_url, :project_night_url
end
