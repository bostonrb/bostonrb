class PresentationsController < ResourceController::Base
  create.wants.html  { redirect_to root_url }
  destroy.wants.html { redirect_to root_url }
  destroy.flash "Presentation deleted."
end
