Rails.application.routes.draw do
  get "posts/create"
  root to: "home#index"

  devise_for :users

  resources :keywords, only: [:index]
  resources :kukais, only: [:show] do
    resources :posts, only: [:create]
  end
end
