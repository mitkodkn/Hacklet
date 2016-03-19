Rails.application.routes.draw do
  # General
  root to: "home#index"
  get "home/index"

  # Custom
  resources :teams
  resources :events
  resources :invites

  # Third party
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  devise_for :users, :controllers => {:registrations => "users/registrations"}

  devise_scope :user do
    post "/users/sign_up" => "users/registrations#create"
    get "users/:id/profile", to: "users/registrations#profile", as: "profile"
    get "users/:id/projects", to: "users/registrations#projects", as: "user_projects"
    get "users/:id/settings", to: "users/registrations#settings", as: "user_settings"
  end
end
