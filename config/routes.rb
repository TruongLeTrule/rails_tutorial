Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "home#index"
    get "/contact", to: "contact#index"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources  :users, only: %i(show new create)
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
  end
end
