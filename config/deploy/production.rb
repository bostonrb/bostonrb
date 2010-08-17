set :rails_env, 'production'
server 'production.bostonrb.managedmachine.com', :app, :web, :db, :primary => true
