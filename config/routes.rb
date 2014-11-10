Rails.application.routes.draw do

  devise_for :users

  resources :tracked_domains do
    resources :events
  end
  
  resources :verifications, only: [:update]
  match 'events' => "events#index", via: :options

  root 'tracked_domains#index' 

end
