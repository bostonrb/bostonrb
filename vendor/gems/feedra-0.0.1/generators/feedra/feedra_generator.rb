class FeedraGenerator < Rails::Generator::Base

  def manifest
    record do |m|
      m.template 'feed.rb', 'app/models/feed.rb'
      m.template 'feed_error.rb', 'app/models/feed_error.rb'
      m.template 'entry.rb', 'app/models/entry.rb'
      m.migration_template 'migration.rb', 'db/migrate', :migration_file_name => 'create_feed_and_events'
    end
    
  end

end
