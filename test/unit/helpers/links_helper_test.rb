require 'test_helper'

class LinksHelperTest < ActionView::TestCase
  context "link to each companies" do
    setup do
      @companies = [Factory(:company), Factory(:company)]
      @links     = link_to_each(@companies)
    end

    should "be an Array of links for those companies" do
      expected = [link_to(@companies.first.to_s, @companies.first),
                  link_to(@companies.last.to_s,  @companies.last)]
      assert_equal expected, @links
    end
  end
end
