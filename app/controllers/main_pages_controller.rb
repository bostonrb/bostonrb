class MainPagesController < ApplicationController

  def home
    @meetup = MonthlyMeeting.last
  end

  def calendar
  end

  def project_night
    @project_night = ProjectNight.last
  end

end
