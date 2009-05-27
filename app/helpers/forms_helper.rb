module FormsHelper
  def companies_select_options
    Company.alphabetical.collect { |company| [company.name, company.id] }
  end
end
