require File.dirname(__FILE__) + '/../test_helper'

class CompanyTest < ActiveSupport::TestCase
  context "a company" do
    setup do
      @company = Factory(:company, :name => "Nike")
    end

    subject { @company }

    should_validate_presence_of   :name
    should_validate_uniqueness_of :name
    should_validate_url_format_of :website_url

    should_have_one  :feed, :dependent => :destroy
    should_have_many :employees#, :class_name => User

    should "display name as string representation" do
      assert_equal "Nike", @company.to_s
    end
  end

  context "alphabetical" do
    setup do
      Factory(:company, :name => "B")
      Factory(:company, :name => "A")
      Factory(:company, :name => "C")
      @companies = Company.alphabetical
    end

    should "be companies listed alphabetically" do
      expected = Company.all.sort_by(&:name)
      assert_equal expected, @companies
    end
  end
end
