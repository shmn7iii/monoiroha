Rails.application.routes.draw do
  root 'items#index'

  resources :items, only: %i[index]
  resources :users, only: %i[index]
  resources :transactions, only: %i[show]

  get  '/orders/progress', to: 'orders#progress'
  post '/orders/create',   to: 'orders#create'
  get  '/orders/complete', to: 'orders#complete'

  get  '/votes/progress', to: 'votes#progress'
  post '/votes/create',   to: 'votes#create'
  get  '/votes/complete', to: 'votes#complete'
end
