Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "home#index"
    get "/contact", to: "contact#index"
    get "/signup", to: "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "password_resets/new"
    get "password_resets/edit"
    get "microposts", to: "home#index"
    resources  :users do
      member do
        get :followers, :following
      end
    end
    resources :account_activations, only: %i(edit)
    resources :password_resets, only: %i(new create edit update)
    resources :microposts, only: %i(create destroy)
    resources :relationships, only: %i(create destroy)
  end
end
