# == Schema Information
# Schema version: 13
#
# Table name: projects
#
#  id           :integer(11)     not null, primary key
#  name         :string(255)     
#  homepage_url :string(255)     
#  feed_url     :string(255)     
#  created_at   :datetime        
#  updated_at   :datetime        
#  description  :text            
#  deleted_at   :datetime        
#

class Project < ActiveRecord::Base
  
  has_many :commits, :limit => 5, :order => 'published_at desc', :dependent => :destroy
  
  has_finder :all, :order => 'name asc'

  acts_as_paranoid
  
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
