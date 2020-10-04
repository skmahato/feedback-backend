Rails.application.routes.draw do
  default_url_options :host => "localhost:4000"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'home#index'

  namespace :api, defaults: { format: :json } do
    post "/login",             to: "sessions#create"
    post "/signup",            to: "users#create"
    get "/current_user",       to: "users#authenticate_user"

    resources :dealerships, only: [:index, :show, :create, :update, :destroy] do
      resources :reviews, only: [:index, :create, :update, :destroy]
    end
  end
end
