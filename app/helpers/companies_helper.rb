module CompaniesHelper
  def company_links
    companies = ["thoughtbot", "Sermo", "Enlight Solutions",
                 "Big Room Technology"]
    companies.collect { |company| link_to(company, "#") }
  end
end
