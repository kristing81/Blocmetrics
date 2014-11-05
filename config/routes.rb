Rails.application.routes.draw do

  devise_for :users

  resources :tracked_domains 
  resources :events
    
 
  root to: 'tracked_domains#index' 
end
