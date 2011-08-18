desc "Cron Tasks"
task :cron => :environment do
  BostonRbCalendar.cache_next_event
end
