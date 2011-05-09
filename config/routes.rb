Meps::Application.routes.draw do

  get "admin/index"

  get "demands/index"

  get "pages/home"
  get "pages/info"
  get "pages/vote"



  devise_for :users
  resources :orders
  resources :users
  resources :admins
  resources :trashcans

  resources :demands

  root :to => "pages#home"

  match '/', :to => 'pages#home'
  match '/info', :to => 'pages#info'
  match '/demands/vote/' => 'demands#vote'
end
