Rails.application.routes.draw do
  root 'welcome#index'
  resources :user_stocks, only: %i[create destroy]
  devise_for :users
  resources :friendships, only: %i[destroy]
  # resources :friendships, only: %i[index]
  get 'my_friends', to: 'users#my_friends'
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stock', to: 'stocks#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
