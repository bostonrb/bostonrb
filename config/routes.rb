BostonRuby::Application.routes.draw do
  root :to => 'high_voltage/pages#show', :id => 'home'
  get '/hackfests' => 'high_voltage/pages#show', :id => 'hackfests', :as => 'hackfests'
  get '/calendar' => 'high_voltage/pages#show', :id => 'calendar', :as => 'calendar'
  match '/jobs' => redirect('/')
  match '/projects' => redirect('/')
  resources :proposals, :only => [:new, :create]
  get '/presentations/month/:month/' => 'presentations#index', :as => 'month_presentations'
  resources :presentations, :only => [:index, :show]
end
