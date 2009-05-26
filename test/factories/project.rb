Factory.define :project do |project|
  project.name       { "Paperclip" }
  project.github_url { "http://github.com/thoughtbot/paperclip" }
  project.association(:user)
end
