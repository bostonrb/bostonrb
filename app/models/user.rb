class User < ActiveRecord::Base
  include Clearance::User
  include Pacecar
  is_gravtastic
  has_many :tweets
end
