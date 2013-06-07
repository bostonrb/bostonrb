BostonRuby::Application.routes.draw do
  %w{jobs projects users companies}.each do |dead_route|
    match "/#{dead_route}" => redirect('/')
  end

  # root :to => 'high_voltage/pages#show', :id => 'home'
  # get '/calendar' => 'high_voltage/pages#show', :id => 'calendar', :as => 'calendar'
  root :to => 'main_pages#home'
  get '/calendar' => 'main_pages#calendar'
  get '/project_night' => 'main_pages#project_night'
  resources :proposals, :only => [:new, :create]
  get '/presentations/month/:month/' => 'presentations#index', :as => 'month_presentations'
  get '/presentations/upcoming' => 'presentations#index', :as => 'upcoming_presentations', :defaults => { :upcoming => true }
  resources :presentations, :only => [:index, :show]
  get '/presenters/leaders' => 'leader_board#index'
  resources :presenters, :only => [:show]
  # get '/project_night' => 'high_voltage/pages#show', :id => 'project_night', :as => 'project_night'

  namespace 'admin' do
    resources 'presentations' do
      collection do
        get "month/:month" => :index, :as => "month"
      end
    end
    resources 'blogs'
    resources 'meetups'
  end
end
