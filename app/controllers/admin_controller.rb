class AdminController < ApplicationController
  #http_basic_authenticate_with name: BostonRuby::Admin[:username], password: BostonRuby::Admin[:password]
  # Put the before filter to authenticate here I think

  before_filter :logged_in

  def logged_in
    raise ActionController::RoutingError.new('Not Found') unless signed_in?
  end
end
