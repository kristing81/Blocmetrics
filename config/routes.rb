Rails.application.routes.draw do

  devise_for :users

  resources :tracked_domains do
    resources :events
  end
  
  resources :verifications, only: [:update]

  namespace :api do
    namespace :v1 do
      resources :events, only: [:create]
    end
  end
  
  options 'api/v1/events.json' => "api/v1/events#index"

  root 'tracked_domains#index' 

end
