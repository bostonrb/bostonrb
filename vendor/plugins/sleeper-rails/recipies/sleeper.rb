after "deploy",            "deploy:notify_sleeper"
after "deploy:migrations", "deploy:notify_sleeper"

namespace :deploy do
  desc "Notify Sleeper of the deployment"
  task :notify_sleeper do
    rails_env = fetch(:rails_env, "production")
    local_user = ENV['USER'] || ENV['USERNAME']
    notify_command = "rake sleeper:deploy"
    puts "Notifying Sleeper of Deploy"
    `#{notify_command}`
    puts "Sleeper Notification Complete."
  end
end
