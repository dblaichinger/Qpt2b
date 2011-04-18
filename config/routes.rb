Meps::Application.routes.draw do

  get "pages/home"
  get "pages/info"

  devise_for :users

  root :to => "pages#home"

  match '/', :to => 'pages#home'
end
