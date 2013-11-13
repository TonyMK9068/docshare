Docshare::Application.routes.draw do
  devise_for :users

  resources :charges, only: :create

  resources :pages do
    resources :roles, only: [:create, :destroy]
  end

  match 'about', to: 'welcome#about', via: :get
  root :to => 'welcome#index'
end