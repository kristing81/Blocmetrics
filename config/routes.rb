Rails.application.routes.draw do

  devise_for :users

  resources :tracked_domains do
    resources :events
  end
  
  resources :verifications, only: [:update]

  namespace :api do
    namespace :v1 do
      resources :events, only: [:create, :index]
      match 'events.json' => "events#create", via: :options, as: :events_options
    end
  end

  #options 'api/v1/events.json' => "api/v1/events#index"
  match 'api/v1/events.json' => "api/v1/events#index", via: :options
  get 'get_started' => 'welcome#get_started', path: 'get_started'

  root 'welcome#index' 

end
