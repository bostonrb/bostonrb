desc "Cron Tasks"
task :cron => :environment do
  cache_next_event
end

def cache_next_event
  Rails.cache.write(:next_event, BostonRbCalendar.next_event)
end

