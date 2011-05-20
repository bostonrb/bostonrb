BostonRuby::Application.routes.draw do
  root :to => 'high_voltage/pages#show', :id => 'home'

  resources :proposals, :only => [:new, :create]
  get '/presentations/month/:month/' => 'presentations#index', :as => 'month_presentations'
  resources :presentations, :only => [:index, :show]
end
