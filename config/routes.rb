Monologue::Engine.routes.draw do
  root to: "posts#index"
  
  namespace :admin do
    get "/" => "admin#index", as: "" # responds to admin_url and admin_path
    get "logout" => "sessions#destroy"
    get "login" => "sessions#new"
    resources :sessions
    resources :posts
  end
  
  match "*post_url" => "posts#show"
end