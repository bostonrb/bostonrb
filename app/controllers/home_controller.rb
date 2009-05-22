class HomeController < ApplicationController

  def index
    @recurring_events      = Event.next(4).recurring
    @special_events        = Event.next(5).special

    @users                 = User.ordered("updated_at desc")

    @recent_tweets         = Tweet.recent(5)
    # @recent_blogs

    @featured_project      = Project.featured
    @recent_projects       = Project.ordered.limited(5)

    # @recent_apps

    @featured_job          = Job.featured
    @recent_jobs           = Job.ordered.limited(5)

    @recent_companies      = Company.ordered.limited(5)

    @featured_presentation = Presentation.featured
    @recent_presentations  = Presentation.ordered.limited(5)
  end

end
