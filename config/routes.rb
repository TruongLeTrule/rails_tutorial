Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "home#index"
    get "contact/index"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources  :users, only: %i(show new create)
  end
end
