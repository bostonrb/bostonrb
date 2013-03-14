require 'fileutils'
module Blog::TestHelpers
  def setup_blog_feeds(date)
    feed_path = "#{Rails.root}/tmp/blog_feeds"
    if FileTest.exists?(feed_path)
      FileUtils.remove_dir feed_path, true
      FileUtils.ln_sf      "#{File.expand_path("../../blog_feeds/#{date}", __FILE__)}", "#{Rails.root}/tmp/blog_feeds"
    end
  end
end
