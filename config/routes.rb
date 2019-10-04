Rails.application.routes.draw do
  get 'friendships/create'
  get 'friendships/destroy'
  get 'friendships/update'
  get 'likes/create'
  get 'likes/destroy'
  resources :comments
  root 'posts#index'

  get 'users', to: 'users#index'
  resources :posts

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    delete 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  get 'users/:username', to: 'users#show', as: 'user'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
