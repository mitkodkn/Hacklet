Rails.application.routes.draw do
  resources :event_photos
  resources :issues
  # General
  root to: "home#index"
  get "home/index"

  get 'attendances/create/:event_id/:user_id',
    to: 'attendances#create', as: 'create_attendance'
  get 'qr/:event_id/:user_id/code', to: 'qr_codes#show', as: 'qr_code'

  # Custom
  resources :teams
  resources :events
  resources :mentors
  resources :projects do
    member do
      get 'submit'
    end
  end

  get "sponsors", to: "sponsors#index"

  get "search/users", to: "search#users"
  get "search/technologies", to: "search#technologies"
  get "search/categories", to: "search#categories"

  get "invites/:id/new", to: "invites#new", as: "new_invite"
  post "invites/create", to: "invites#create"
  get "invites/accept/:token", to: "invites#accept"
  get "invites/decline/:token", to: "invites#decline"

  # Third party
  get "blog/posts/:id", to: "posts#show", as: "post"

  mount Blogit::Engine => "/blog", as: "blog"
  mount Blogit::Admin::Engine => "/blog/admin"
  mount RailsAdmin::Engine => "/admin", as: "rails_admin"
  devise_for :users, :controllers => {:registrations => "users/registrations"}

  devise_scope :user do
    post "users/sign_up" => "users/registrations#create"
    get "users/:id/profile", to: "users/registrations#profile", as: "profile"
    get "users/:id/projects", to: "users/registrations#projects", as: "user_projects"
    get "users/:id/settings", to: "users/registrations#edit", as: "user_settings"
    get "users/:id/avatar", to: "users/registrations#avatar", as: "user_avatar"
    post "users/:id/change_avatar", to: "users/registrations#change_avatar", as: "change_avatar"
  end
end
