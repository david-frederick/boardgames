# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resources :game, only: [:index, :show]
  get :collection, controller: :game
  get :preorders, controller: :game
  get :wishlist, controller: :game
  get :prev_owned, controller: :game
  get :for_trade, controller: :game
  root to: 'game#index'
end
