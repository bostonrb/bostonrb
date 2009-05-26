module Cron
  def self.get_tweets
    client = TwitterSearch::Client.new
    users  = User.twitter_present
    users.each do |user|
      tweets = client.query "from:#{user.twitter}"
      tweets.each do |tweet|
        unless Tweet.find_by_twitter_id(tweet.id)
          user.tweets.create(:text       => CGI::unescapeHTML(tweet.text),
                             :twitter_id => tweet.id,
                             :tweeted_at => tweet.created_at)
        end
      end
    end
  end

  def self.get_projects
    User.github_present.each do |user|
      Github::User.find(user.github).repositories.each do |repo|
        unless repo.fork
          project = Project.find_or_initialize_by_name(repo.name)
          project.watchers    = repo.watchers
          project.name        = repo.name
          project.description = repo.description
          project.github_url  = repo.url
          project.user        = user
          project.save
        end
      end
    end
  end
end
