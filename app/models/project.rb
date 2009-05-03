class Project < ActiveRecord::Base
  has_markup :description, :cache_html => true

  named_scope :all, :order => 'name asc'

  def self.download_entries
    projects = Project.find :all, :conditions => ['feed_url <> ?', '']
    
    projects.each do |project|
      entries = []
      puts "About to yank #{project.feed_url}"
      feed = FeedNormalizer::FeedNormalizer.parse(open(project.feed_url))
      
      if feed.nil?
        puts "Nothing returned from #{project.feed_url}"
      else
        entries += feed.entries
      
        puts "Got #{feed.entries.size} entries from #{project.feed_url}"

        puts "Saving new commits to the database"
        entries.each do |entry|
          if Commit.find_by_url(entry.url).nil?
            Commit.create :project      => project,
                          :title        => entry.title,
                          :url          => entry.url,
                          :published_at => entry.date_published
          end
        end
      end
    end
  end
end
