class CompaniesController < ResourceController::Base
  create.wants.html { redirect_to root_url }
end
