Rails.application.routes.draw do

  root :to => 'search#index'

  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  post 'logout' => 'user_sessions#destroy', :as => :logout


  
  resources :cars do
    resources :rentals, only: [:new]
  end

  resources :locations, only: :create

  resources :search
 

  
  resources :rentals
  resources :users
  resources :reports
  resources :cards
  resources :cars
  resources :positions
end

