ActionController::Routing::Routes.draw do |map|
  
  map.resources :jobs, :videos, :projects, :events

  map.home '/', :controller => 'projects', :action => 'index'

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

