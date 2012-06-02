Monologue::Engine.routes.draw do
  root :to =>  "posts#index"
  match "/page/:page", :to =>  "posts#index", :as =>  "posts_page"
  match "/feed" => "posts#feed", :as =>  "feed", :defaults => {:format => :rss}

  match "/tags/:tag" =>"tags#show"

  namespace :admin, :path => "monologue" do
    get "/" => "posts#index", :as =>  "" # responds to admin_url and admin_path
    get "logout" => "sessions#destroy"
    get "login" => "sessions#new"
    resources :sessions
    resources :posts
    get "comments" => "comments#show", :as => "comments"
  end

  match "*post_url" => "posts#show", :as =>  "post"
end