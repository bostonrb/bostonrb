class MainPagesController < ApplicationController

  def home
    @meetup = Meetup.last
  end

  def calendar
  end

  def project_night
    @meetup = Meetup.last
  end

end
