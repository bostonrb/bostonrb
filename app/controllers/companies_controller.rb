class CompaniesController < ResourceController::Base
  create.wants.html { redirect_to root_url }
  create.flash "Company created."
  update.wants.html { redirect_to company_path(@company) }
  update.flash "Company updated."
end
