require 'test_helper'

class CompaniesHelperTest < ActionView::TestCase
  context "setup_company" do
    should "return the company" do
      company = Factory.build(:company)

      assert_same company, setup_company(company)
    end

    should "build feed if it doesn't exist" do
      company = Factory.build(:company)

      setup_company(company)

      assert_not_nil company.feed
    end

    should "keep original feed if it is present" do
      feed = Factory.build(:feed)
      company = Factory.build(:company, :feed => feed)

      setup_company(company)

      assert_same feed, company.feed
    end

  end
end
