module FixtureReplacement
  attributes_for :project do |project|
    project.name = 'recommendable'
    project.homepage_url = 'http://github.com/dancroak/recommendable/tree/master'
    project.feed_url = 'http://github.com/feeds/dancroak/commits/recommendable/master'
    project.description = 'A Rails plugin for Amazon.com-style item-to-item collaborative filtering.'
  end
  

  attributes_for :job do |job|
    job.location = 'Boston, MA'
  end
  
  attributes_for :gig_job, :from => :job do |job|
    job.location = 'Boston, MA'
    job.organization = 'thoughtbot'
    job.title = 'Rails developer'
    job.description = 'Full time stuff'
    job.gig = true
  end

  attributes_for :fulltime_job, :from => :job do |job|
    job.location = 'Boston, MA'
    job.organization = 'thoughtbot'
    job.title = 'Rails developer'
    job.description = 'Full time stuff'
    job.gig = false
  end
  
  attributes_for :event do |event|
    event.title = 'Hackfest'
    event.date = Time.now
    event.description = 'a cool hackfest'
  end
  
  attributes_for :hackfest_event, :from => :event do |event|
    event.title = 'Hackfest'
    event.date = Time.now
    event.description = 'a cool hackfest'
  end
  
  attributes_for :video do |video|
    video.title = 'Shoulda tutorial'
    video.presenter = 'Tammer Saleh'
    video.source = 'Some crazy conference'
    video.url = 'http://video.google.com'
  end
  
  attributes_for :commit do |commit|
    commit.title = 'Messing with git configs, updating README to declare "alpha" status.'
    commit.url = 'http://github.com/dancroak/recommendable/commit/51bac8797bcc33b77790a822b4fcaa4edf844e86'
    commit.published_at = DateTime.now
    commit.project = Factory.build_project
  end
end