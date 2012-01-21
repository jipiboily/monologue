Monologue::Engine.routes.draw do
  namespace :admin do
    get "/" => "admin#index", as: "" # responds to admin_url and admin_path
    get "logout" => "sessions#destroy"
    get "login" => "sessions#new"
    resources :sessions
    resources :posts_revisions, path: "posts"
  end
end
