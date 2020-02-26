# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  resources :game, only: [:index, :show]

  root to: 'game#index'
end
