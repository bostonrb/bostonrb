require 'test_helper'

class FormsHelperTest < ActionView::TestCase
  context "companies select options" do
    setup do
      @companies = [Factory(:company), Factory(:company)]
      @options   = companies_select_options
    end

    should "be a collection of names and ids for those companies" do
      expected = [[@companies.first.name, @companies.first.id],
                  [@companies.last.name,  @companies.last.id]]
      assert_equal expected, @options
    end
  end
end
