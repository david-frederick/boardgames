# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  get 'collection/index'
  resources :game, only: [:index, :show]
  resources :collection, only: [:index]
  root to: 'collection#index'
end
