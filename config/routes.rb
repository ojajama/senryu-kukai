Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  root to: "home#index"

  devise_for :users

  resources :keywords, only: [:index]
  resources :kukais, only: [:index, :show] do
    member do
      get :ranking
    end
    resources :keywords, only: [:show], controller: "kukai_keywords"
    resources :posts, only: [:create]
  end

  resources :users, only: [:index] do
    resources :posts, only: [:index], controller: "user_posts"
  end

  resources :posts, only: [:edit, :update, :destroy] do
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create]
    resources :post_revisions, only: [:index]
  end

  resources :post_revisions, only: [:show] do
    member do
      patch :restore
      post :ai_comment
    end
  end

  namespace :admin do
    resources :keywords, only: [:index, :edit, :update]
    resources :kukais, only: [:index, :new, :create, :edit, :update] do
      member do
        post :add_random_keyword
        post :add_keyword
        delete "keywords/:keyword_id", action: :remove_keyword, as: :keyword
      end
    end
  end

end
