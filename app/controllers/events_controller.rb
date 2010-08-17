class EventsController < InheritedResources::Base
  actions :new, :edit, :show, :create, :update, :destroy

  def index
    respond_to do |wants|
      wants.html { @events = Event.paginate_by_date params[:page] }
      wants.atom { @events = Event.next(10) }
      wants.rss  { redirect_to :format => :atom }
      wants.ics do
        @events = Event.next(10)
        render :text => ical(@events).to_s, :content_type => Mime::ICS
      end
    end
  end

  def create
    create! { root_url }
  end

  def destroy
    create! { root_path }
  end

  def copy
    @template_event = resource
    @event = @template_event.clone
    render :action => :new
  end
  
  protected
  
  def ical(events)
    RiCal.Calendar do |cal|
      events.each do |event|
        cal.event do |e|
          e.summary = event.title
          e.security_class = 'PUBLIC'
          e.created = event.created_at
          e.dtstart = event.date
          e.dtend = event.date + 2.hours
          #e.geo_property = "#{event.lat};#{event.lng}"
          e.location = event.location
          e.last_modified = event.updated_at
          e.dtstamp = Time.now.utc
          e.uid = "event-#{event.id}@bostonrb.org"
          e.url = event_url(event)
          e.add_categories ['RUBY']
        end
      end
    end
  end
end
