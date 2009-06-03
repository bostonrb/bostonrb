require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase
  should_route :get, '/companies/new', :controller => 'companies', :action => 'new'

  context "on GET to #new when signed out" do
    setup { get :new }
    should_deny_access
  end

  context "on GET to #new when signed in" do
    setup do
      sign_in
      get :new
    end

    should_assign_to       :company
    should_render_template :new
    should_respond_with    :success

    should 'have new_company form' do
      assert_select 'form[id=new_company]' do
        should_have_company_form_fields
        assert_select 'input[type=submit][id=company_submit]'
      end
    end
  end

  should_route :post, '/companies',
    :controller => 'companies', :action => 'create'

  context "on POST to #create when signed out" do
    setup { post :create }
    should_deny_access
  end

  context 'on POST to #create when signed in' do
    setup do
      sign_in
      post :create,
        :company => Factory.attributes_for(:company, :name => "new company")
    end

    should_set_the_flash_to /company created/i
    should_redirect_to("home") { root_path }
    should "create Company" do
      assert Company.find_by_name("new company")
    end
  end

  should_route :get, '/companies/1',
    :controller => 'companies', :action => 'show', :id => '1'

  context 'on GET to #show for a company not on Twitter' do
    setup do
      @company = Factory(:company, :twitter => nil)
      get :show, :id => @company.id
    end

    should "not show Twitter" do
      assert_select "ul.details li.clearfix .label",
        :text => "Twitter", :count => 0
    end
  end

  context 'on GET to #show for a company on Twitter' do
    setup do
      @company = Factory(:company, :twitter => "thoughtbot")
      get :show, :id => @company.id
    end

    should "show Twitter" do
      assert_select "ul.details li.clearfix .detail", :text => "thoughtbot"
      assert_select "ul.details li.clearfix .label",  :text => "Twitter"
    end
  end

  context "on GET to #show for a company with employees" do
    setup do
      @employee_a = Factory(:email_confirmed_user)
      @employee_b = Factory(:email_confirmed_user)
      @employees = [@employee_a, @employee_b]

      @company = Factory(:company)
      @company.employees << @employees
      get :show, :id => @company.to_param
    end

    should "show Employees" do
      assert_select "h3", :text => "Employees"
      assert_select "ul.employees" do
        assert_select "li a[href=?]", user_path(@employee_a),
          :text => @employee_a.github
        assert_select "li a[href=?]", user_path(@employee_b),
          :text => @employee_b.github
      end
    end
  end

  should_route :get, "/companies/1/edit",
    :controller => 'companies', :action => 'edit', :id => '1'

  context "on GET to #edit when signed out" do
    setup { get :edit, :id => 1 }
    should_deny_access
  end

  context 'on GET to :edit when signed in' do
    setup do
      sign_in
      @company = Factory(:company)
      get :edit, :id => @company.to_param
    end

    should_assign_to       :company
    should_render_template :edit
    should_respond_with    :success

    should 'have company form' do
      assert_select "form[id=edit_company_#{@company.to_param}]" do
        should_have_company_form_fields
        assert_select 'input[type=submit][id=company_submit]'
      end
    end

    should 'have add employee form' do
      assert_select "form[action=?]", company_employees_path(@company) do
        assert_select 'input[type=text][name=?]',    'user[github]'
        assert_select 'input[type=submit][value=?]', 'Add Employee'
      end
    end

    should 'have delete link' do
      assert_select ".crud p a", "Delete"
    end
  end

  should_route :put, "/companies/1",
    :controller => 'companies', :action => 'update', :id => '1'

  context "on PUT to #update when signed out" do
    setup { put :update, :id => 1 }
    should_deny_access
  end

  context 'on PUT to #update when signed in' do
    setup do
      sign_in
      @company = Factory(:company)
      put :update, :id      => @company.to_param,
                   :company => { :name => 'different' }
    end

    should 'update company name' do
      assert_equal "different", @company.reload.name
    end

    should_set_the_flash_to /company updated/i
    should_redirect_to("company page") { company_path(@company) }
  end

  context 'on PUT to #update with bad parameters when signed in' do
    setup do
      sign_in
      @company = Factory(:company, :name => "original")
      put :update, :id => @company.to_param, :company => { :name => '' }
    end

    should 'not update company name' do
      assert_equal "original", @company.reload.name
    end

    should_assign_to       :company
    should_render_template :edit
    should_respond_with    :success

    should 'have update company form' do
      assert_select "form[id=edit_company_#{@company.to_param}]" do
        should_have_company_form_fields
        assert_select 'input[type=submit][id=company_submit]'
      end
    end
  end

  protected

  def should_have_company_form_fields()
    assert_select 'input[id=company_name][type=text]'
    assert_select 'input[id=company_website_url][type=text]'
    assert_select 'input[id=company_twitter][type=text]'
  end

end

