class PasswordsController < Clearance::PasswordsController
  skip_before_filter :authenticate, :only => [:new, :create, :edit, :update]
end

