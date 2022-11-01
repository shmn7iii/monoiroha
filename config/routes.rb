Rails.application.routes.draw do
  root 'items#index'

  resources :items, only: %i[index]
  resources :users, only: %i[index]
  resources :transactions, only: %i[show]

  get '/users/:id/vote',     to: 'users#vote'
  get  '/orders/progress', to: 'orders#progress'
  post '/orders/create',   to: 'orders#create'
  get  '/orders/complete', to: 'orders#complete'
end
