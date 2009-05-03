module CompaniesHelper
  def sentence_of_linkable_companies
    companies = ["thoughtbot", "Sermo", "Enlight Solutions",
                 "Big Room Technology"]
    linkable_companies = companies.collect do |company|
      link_to company, "#"
    end
    linkable_companies.to_sentence
  end
end
