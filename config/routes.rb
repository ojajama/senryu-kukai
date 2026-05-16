Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  root to: "home#index"

  devise_for :users, controllers: { registrations: "users/registrations" }

  get  "/invite/:token",          to: "invitations#show",     as: :invitation
  get  "/invite/:token/complete", to: "invitations#complete",  as: :complete_invitation
  post "/invite/:token/register", to: "invitations#register",  as: :register_invitation

  get "/ranking(/:year)", to: "ranking#show", as: :ranking, constraints: { year: /\d{4}/ }

  resources :keywords, only: [:index]
  resources :kukais, only: [:index, :show] do
    member do
      get :ranking
    end
    resources :keywords, only: [:show], controller: "kukai_keywords"
    resources :posts, only: [:create]
    resources :selections, only: [:create, :destroy]
  end

  resources :users, only: [:index] do
    resources :posts, only: [:index], controller: "user_posts"
  end

  resources :posts, only: [:show, :edit, :update, :destroy] do
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
    resources :invitations, only: [:index, :create]
    resources :users, only: [:index, :edit, :update]
    resources :keywords, only: [:index, :edit, :update]
    resources :ai_guidelines, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :post_revisions, only: [] do
      member do
        post :save_as_example
      end
    end
    resources :kukais, only: [:index, :new, :create, :edit, :update] do
      member do
        post :add_random_keyword
        post :add_keyword
        post :start_selection
        post :reveal
        delete "keywords/:keyword_id", action: :remove_keyword, as: :keyword
      end
    end
  end

end
