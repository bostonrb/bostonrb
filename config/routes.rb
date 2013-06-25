BostonRuby::Application.routes.draw do
  %w{jobs projects users companies}.each do |dead_route|
    match "/#{dead_route}" => redirect('/')
  end

  root :to => 'main_pages#home'
  get '/calendar' => 'main_pages#calendar'
  get '/project_night' => 'main_pages#project_night'
  resources :proposals, :only => [:new, :create]
  get '/presentations/month/:month/' => 'presentations#index', :as => 'month_presentations'
  get '/presentations/upcoming' => 'presentations#index', :as => 'upcoming_presentations', :defaults => { :upcoming => true }
  resources :presentations, :only => [:index, :show]
  get '/presenters/leaders' => 'leader_board#index'
  resources :presenters, :only => [:show]

  namespace 'admin' do
    resources 'presentations' do
      collection do
        get "month/:month" => :index, :as => "month"
      end
    end
    resources 'blogs'
    resources 'monthly_meetings', only: [:index, :create, :update]
    resources 'project_nights', only: [:index, :create, :update]
  end
end
