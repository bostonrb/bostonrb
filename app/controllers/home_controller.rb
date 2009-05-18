class HomeController < ApplicationController

  def index
    @users = User.all
    @recurring_events = Event.next(4).recurring
  end

end
