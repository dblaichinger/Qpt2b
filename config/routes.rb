Meps::Application.routes.draw do
 
  #get "admin/index"

  #get "demands/index"

  get "pages/home"
  get "pages/gallery"
  get "pages/vote"
  get "pages/search"
  get '/pages/docu_user'
  get '/pages/docu_admin'
  get 'pages/docu_tech'


  devise_for :users  
  devise_for :admins
  resources :orders do
    match 'confirm' => 'orders#confirm', :as => 'confirm'
    match 'decline' => 'orders#decline', :as => 'decline'
  end

  resources :users
  resources :admins
  resources :trashcans
  #resources :designs
  resources :demands
 
  root :to => "pages#home"

  match '/', :to => 'pages#home'
  match '/gallery', :to => 'pages#gallery'
  match '/contact', :to => 'pages#contact'
  match '/pages/search', :to => 'pages#search', :as => 'pages_search'
  match '/demands/vote/' => 'demands#vote', :as => 'demand_vote'
end
