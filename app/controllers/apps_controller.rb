class AppsController < InheritedResources::Base
  actions :new, :create, :edit, :update, :destroy

  def create
    create! { root_url }
  end

  def destroy
    destroy! { root_url }
  end

end
