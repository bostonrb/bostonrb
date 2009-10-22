class EventsController < InheritedResources::Base
  actions :new, :edit, :show, :create, :update, :destroy

  def index
    respond_to do |wants|
      wants.html { @events = Event.paginate_by_date params[:page] }
      wants.atom { @events = Event.next(10) }
      wants.rss  { redirect_to :format => :atom }
    end
  end

  def create
    create! { root_url }
  end

  def destroy
    create! { root_path }
  end
end
