require File.dirname(__FILE__) + '/../test_helper'

class CompanyTest < ActiveSupport::TestCase
  context "a company" do
    setup do
      @company = Factory(:company)
    end

    should_validate_uniqueness_of :name 
    should_validate_url_format_of :website_url 
  end
end
