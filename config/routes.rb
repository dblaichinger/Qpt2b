Meps::Application.routes.draw do

  get "demands/index"

  get "pages/home"
  get "pages/info"

  get "pages/vote"



  devise_for :users
  resources :orders
  resources :users
  resources :trashcans

  resources :demands, :only => [:index, :update, :create]

  root :to => "pages#home"

  match '/', :to => 'pages#home'
  match '/info', :to => 'pages#info'
end
