class Feed < ActiveRecord::Base
  include Feedra::Feed

  belongs_to :user
end
