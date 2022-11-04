Rails.application.routes.draw do

  root :to => 'search#index'

  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  post 'logout' => 'user_sessions#destroy', :as => :logout
  
  resources :users do
    resources :cars do
      resources :rentals, only: [:new]
    end
  end
  
  resources :rentals
  resources :users
  resources :reports
  resources :cards
  resources :cars
  resources :positions
end
