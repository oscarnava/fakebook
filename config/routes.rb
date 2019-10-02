Rails.application.routes.draw do
  resources :comments
  root 'posts#index'

  get 'users', to: 'users#index'
  resources :posts
  devise_for :users
  get 'users/:username', to: 'users#show', as: 'user'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
