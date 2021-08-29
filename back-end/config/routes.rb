Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :ad, only: [:index, :destroy, :show, :create]
  resources :comment, only: [:create, :destroy]
  resources :user, only: [:create]
  post 'login', to: 'user#login'
end
