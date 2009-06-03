class EmployeesController < ApplicationController

  def create
    company  = Company.find(params[:company_id])
    employee = User.find_by_github!(params[:user][:github])
    employee.update_attributes!(:company => company)
    flash[:success] = "Employee added to company"
    redirect_to company
  end

end
