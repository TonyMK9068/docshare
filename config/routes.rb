Docshare::Application.routes.draw do
  resources :pages
  devise_for :users
  resources :charges
  match 'about', to: 'welcome#about', via: :get
  root :to => 'welcome#index'
end