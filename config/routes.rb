ActionController::Routing::Routes.draw do |map|
  map.resources :jobs, :collection => {:old => :get}
  map.resources :videos
  map.resources :projects
  map.resources :events
  map.resources :pages
  map.resources :places

  map.root :controller => 'events', :action => 'index'
end

