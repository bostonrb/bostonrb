class User < ActiveRecord::Base
  include Clearance::User
  include Pacecar
  is_gravtastic
  has_many :presentations
  has_many :tweets
  attr_accessible :twitter
end
