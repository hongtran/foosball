Rails.application.routes.draw do
  get 'matches/ranking' => 'matches#ranking'

  get 'games/index' => 'games#index'
  resources :users
  resources :teams
  resources :matches
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#index'
end
