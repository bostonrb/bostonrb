module CompaniesHelper

  def setup_company(company)
    returning company do
      company.build_feed unless company.feed
    end
  end

end
