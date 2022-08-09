Rails.application.routes.draw do
  devise_for :users
  root 'static_pages#root'
  post '/webhooks/:source', to: 'webhooks#create'

  resource :dashboard
  resources :accounts
  resources :payouts, only: [:create]
  resources :products
  resource :checkout
end
