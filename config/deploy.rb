set :stages, %w(staging production)
set :default_stage, 'staging'
require 'capistrano/ext/multistage' rescue 'YOU NEED TO INSTALL THE capistrano-ext GEM'
# needs to come after multistage
require 'capistrano/gitflow' rescue 'YOU NEED TO INSTALL THE capistrano-gitflow GEM'
