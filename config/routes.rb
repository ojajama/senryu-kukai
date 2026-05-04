Rails.application.routes.draw do
  get "user_posts/index"
  get "kukai_keywords/show"
  get "posts/create"
  root to: "home#index"

  devise_for :users

  resources :keywords, only: [:index]
  resources :kukais, only: [:show] do
    resources :keywords, only: [:show], controller: "kukai_keywords"
    resources :posts, only: [:create]
  end

  resources :users, only: [] do
    resources :posts, only: [:index], controller: "user_posts"
  end
end
