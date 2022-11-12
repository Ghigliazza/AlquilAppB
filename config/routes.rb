Rails.application.routes.draw do

  root :to => 'search#index'

  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  get 'logout' => 'user_sessions#destroy', :as => :logout

  
  resources :cars do
    resources :rentals, only: [:new, :create]
  end

  resources :locations, only: :create

  resources :search

  get '/documents/index' 
 
  
  resources :rentals
  resources :users
  resources :reports
  resources :cards
  resources :cars
  resources :positions
end

