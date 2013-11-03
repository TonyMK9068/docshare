Docshare::Application.routes.draw do
  resources :pages
  devise_for :users
  match 'about', to: 'welcome#about', via: :get
  root :to => 'welcome#index'
resources :charges, only: :create
end