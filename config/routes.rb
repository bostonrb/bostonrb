ActionController::Routing::Routes.draw do |map|
  map.resources :places

  map.resources :jobs, :collection => {:old => :get}
  map.resources :videos
  map.resources :projects
  map.resources :events

  map.site 'site/:name', :controller => 'pages', :action => 'show'

  map.home '/', :controller => 'events', :action => 'index'

  # Install the default routes as the lowest priority.
  # map.connect ':controller/:action/:id'
  # map.connect ':controller/:action/:id.:format'
end

