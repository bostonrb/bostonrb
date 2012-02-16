require 'fileutils'
module Blog::TestHelpers
  def setup_blog_feeds(date)
    FileUtils.remove_dir "#{Rails.root}/tmp/blog_feeds", true
    FileUtils.ln_sf      "#{File.expand_path("../../blog_feeds/#{date}", __FILE__)}", "#{Rails.root}/tmp/blog_feeds"
  end
end
