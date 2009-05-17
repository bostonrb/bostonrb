class UsersController < Clearance::UsersController
  skip_before_filter :authenticate, :only => [:new, :create]
end

