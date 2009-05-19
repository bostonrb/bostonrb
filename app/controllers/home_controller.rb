class HomeController < ApplicationController

  def index
    @users            = User.all
    @recurring_events = Event.next(4).recurring
    @special_events   = Event.next(5).special
    @recent_jobs      = Job.recent
    @recent_tweets    = Tweet.recent(5)
  end

end
