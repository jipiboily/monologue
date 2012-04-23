Rails.application.routes.draw do

  mount Monologue::Engine, :at => "/monologue"
end
