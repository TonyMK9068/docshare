Docshare::Application.routes.draw do
  devise_for :users

  resources :charges, only: :create

  resources :pages do
    resources :viewers, only: [:create, :destroy]
    resources :collaborators, only: [:create, :destroy]

  end

  match 'about', to: 'welcome#about', via: :get
  root :to => 'welcome#index'
end