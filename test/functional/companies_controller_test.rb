require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase
  context "when creating a new company" do
    setup do
      do_new_get 
    end

    should_assign_to :company
  end

  def do_new_get
    get :new
  end
end

