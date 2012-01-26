class AdminController < ApplicationController
  http_basic_authenticate_with name: BostonRuby::Admin[:username], password: BostonRuby::Admin[:password]
end
