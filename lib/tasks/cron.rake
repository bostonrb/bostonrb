desc "Cron Tasks"
task :cron => :environment do
  BostonRbCalendar.cache_next_event
  Blog.update_all_from_feeds
end
