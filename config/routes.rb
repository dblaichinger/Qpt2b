Meps::Application.routes.draw do

  #get "admin/index"

  #get "demands/index"

  get "pages/home"
  get "pages/gallery"
  get "pages/vote"

  devise_for :users do
    get "/login" => "devise/sessions#new"
  end
  devise_for :admins
  resources :orders do
    match 'confirm' => 'orders#confirm', :as => 'confirm'
    match 'confirm' => 'orders#decline', :as => 'decline'
  end

  resources :users
  resources :admins, :only => :index
  resources :trashcans
  #resources :designs
  resources :demands
 
  root :to => "pages#home"

  match '/', :to => 'pages#home'
  match '/gallery', :to => 'pages#gallery'
  match '/contact', :to => 'pages#contact'
  match '/demands/vote/' => 'demands#vote', :as => 'demand_vote'
end
