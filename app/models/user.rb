class User < ActiveRecord::Base
  include Clearance::User
  is_gravtastic
end
