ActionController::Routing::Routes.draw do |map|
  map.resources :jobs, :videos, :projects, :events

  map.site 'site/:name', :controller => 'pages', :action => 'show'

  map.home '/', :controller => 'projects', :action => 'index'

  # Install the default routes as the lowest priority.
  # map.connect ':controller/:action/:id'
  # map.connect ':controller/:action/:id.:format'
end

