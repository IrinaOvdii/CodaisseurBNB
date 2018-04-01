Rails.application.routes.draw do
  root to: 'pages#home'

  devise_for :users


  resources :rooms, except: [:destroy]
  resources :profiles, only: [:new, :edit, :create, :update]
end
