Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users

  resources :rooms do
    resources :bookings, only: [:create, :index, :show]
  end

  resources :profiles, only: [:new, :edit, :create, :update]
  resources :photos, only: [:destroy]
end
