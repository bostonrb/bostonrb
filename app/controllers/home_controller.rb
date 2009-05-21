class HomeController < ApplicationController

  def index
    @users            = User.limited(24)
    @recurring_events = Event.next(4).recurring
    @special_events   = Event.next(5).special
    @recent_jobs      = Job.ordered.limited(5)
    @recent_tweets    = Tweet.recent(5)
    @featured_project = Project.featured
    @recent_projects  = Project.ordered.limited(5)
  end

end
