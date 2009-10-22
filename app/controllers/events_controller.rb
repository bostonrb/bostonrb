class EventsController < InheritedResources::Base
  actions :new, :edit, :show, :create, :update, :destroy

  def index
    respond_to do |wants|
      wants.html { @events = Event.paginate_by_date params[:page] }
      wants.atom { @events = Event.next(10) }
      wants.rss { 
        @new_feed_url = request.url.gsub!("rss", "atom")
        @message = "Please use our Atom feed instead:<br />" +
        "<a href='#{@new_feed_url}'>#{@new_feed_url}</a>" 
      }
    end
  end

  def create
    create! { root_url }
  end

  def destroy
    create! { root_path }
  end
end
