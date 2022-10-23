Rails.application.routes.draw do
  root 'items#index'

  resources :items, only: %i[index]
  resources :users, only: %i[index]

  get '/items/:id/purchase', to: 'items#purchase'
  get '/users/:id/vote',     to: 'users#vote'
end
