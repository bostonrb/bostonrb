class SessionsController < Clearance::SessionsController
  skip_before_filter :authenticate, :only => [:new, :create, :destroy]
end
