class HomeController < ApplicationController

  def index
    @users            = User.limited(24)
    @recurring_events = Event.next(4).recurring
    @special_events   = Event.next(5).special
    @recent_jobs      = Job.recent
    @recent_tweets    = Tweet.recent(5)
    @featured_project = Project.featured
    @projects         = Project.all
    @projects         = @projects.select { |p| p != @featured_project } if @featured_project
  end

end
