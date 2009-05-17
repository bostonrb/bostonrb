class ConfirmationsController < Clearance::ConfirmationsController
  skip_before_filter :authenticate, :only => [:new, :create]
end

