Meps::Application.routes.draw do

  get "pages/home"
  get "pages/info"

  devise_for :users
  resources :orders

  root :to => "pages#home"

  match '/', :to => 'pages#home'
end
