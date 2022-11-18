Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :gyms do
    resources :bookings, only: [:create]
  end
  resources :bookings, only: [:edit, :update, :index]
  get 'profile', to: 'pages#show', as: :profile
  patch '/bookings/:id/accept', to: 'bookings#accept', as: :accept_booking
  patch '/bookings/:id/reject', to: 'bookings#reject', as: :reject_booking

  # Defines the root path route ("/")
  # root "articles#index"
  end
