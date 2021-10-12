Rails.application.routes.draw do
  get 'main',to:"main#main"
  post 'login',to:"main#login"
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
