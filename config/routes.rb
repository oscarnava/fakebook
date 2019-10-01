Rails.application.routes.draw do
  root 'posts#index'

  get 'users/:id', to: 'users#show', id: /\d+/, as: 'user'
  get 'users', to: 'users#index'
  resources :posts
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
