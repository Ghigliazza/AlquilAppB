Rails.application.routes.draw do
  resources :payments

  root :to => 'search#index'

  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  get 'logout' => 'user_sessions#destroy', :as => :logout

  
  resources :cars do
    resources :rentals, only: %i[new edit]
  end

  resources :rentals do
    resources :reports, only: :new
  end

  resources :locations, only: :create

  resources :search, only: :index

  get '/documents/index' 

  get '/users/editar_perfil'
 
  get 'rentals/:id/cancel', to: 'rentals#cancel', :as => :cancel_rental

  get 'supervisors/index'
  get 'supervisors/new_password'
  get 'supervisors/search'
  get 'supervisors/delete'

  get 'drivers/index'
  get 'drivers/search'

  get 'users/suspended'

  patch 'cards/:id/balance', to: 'cards#balance', :as => :balance_card

  get 'fines/index'
  resources :fines do
    resources :fines, only: :new
  end

  resources :rentals do
    resources :payments, only: :index
  end

  resources :api, only: :index
 
  resources :rentals
  resources :users
  resources :reports
  resources :cards
  resources :cars
  resources :positions
end

