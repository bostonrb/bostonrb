class CompaniesController < InheritedResources::Base

  def create
    create! { root_url }
  end

end
