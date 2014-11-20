Rails.application.routes.draw do

  get 'welcome/index'

  get 'welcome/get_started'

  devise_for :users

  resources :tracked_domains do
    resources :events
  end
  
  resources :verifications, only: [:update]

  namespace :api do
    namespace :v1 do
      resources :events, only: [:create, :index, :show]
    end
  end
  
  #options 'api/v1/events.json' => "api/v1/events#index"
  match '/api/v1/events.json' => "/api/v1/events#index", via: :options
  get 'get_started' => 'welcome#get_started', path: 'get_started'

  root 'welcome#index' 

end
