require 'test_helper'

class EmployeesControllerTest < ActionController::TestCase

  should_route :post, "/companies/1/employees",
    :action => :create, :company_id => 1

  context 'POST to create with valid parameters' do
    setup do
      sign_in
      @company = Factory(:company)
      @user    = Factory(:user, :github => "dancroak")
      post :create,
        :company_id => @company.to_param,
        :user       => { :github => @user.github }
    end

    should "associate an employee for the company" do
      assert_equal @company, @user.reload.company
    end
    should_set_the_flash_to /employee added to company/i
    should_redirect_to("company page") { company_path(@company) }
  end

end

