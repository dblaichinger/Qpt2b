Meps::Application.routes.draw do

  get "demands/index"

  get "pages/home"
  get "pages/info"

  devise_for :users
  resources :orders

  resources :users

  resources :demands, :only => [:index, :show]

  root :to => "pages#home"

  match '/', :to => 'pages#home'
end
