class MainPagesController < ApplicationController

  def home
    @meetup = MonthlyMeeting.last
  end

  def calendar
  end

  def project_night
    @meetup = ProjectNight.last
  end

end
