Rails.application.routes.draw do

  devise_for :users

  resources :tracked_domains do
    resources :events
  end
 
  root 'tracked_domains#index' 
end
