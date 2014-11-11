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
  
  match 'events' => "events#index", via: :options

  root 'tracked_domains#index' 

end
