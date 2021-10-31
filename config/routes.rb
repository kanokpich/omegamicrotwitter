Rails.application.routes.draw do
  resources :likes
  resources :follows
  resources :posts
  get 'main',to:"main#main"
  post 'login',to:"main#login"
  get 'register',to:"main#register"
  post 'register',to:"main#regsiter_create"
  get 'feed',to:"main#feed"
  get 'new_post',to:"main#new_post"
  post 'create_post',to:"main#create_post"
  get 'profile',to:"main#profile"
  get 'profile/:name',to:"main#profile"
  post 'follow',to:"main#follow"
  post 'like/:post_id', to:"main#like"
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
