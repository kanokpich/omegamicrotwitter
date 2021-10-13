Rails.application.routes.draw do
  resources :posts
  get 'main',to:"main#main"
  post 'login',to:"main#login"
  get 'register',to:"main#register"
  post 'register',to:"main#regsiter_create"
  get 'feed',to:"main#feed"
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
