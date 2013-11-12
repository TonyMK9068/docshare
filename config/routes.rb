Docshare::Application.routes.draw do
  devise_for :users

  resources :charges, only: :create

  resources :pages do
    match '/add-collab', to: 'collaborator#create', as: :create_collab
    match '/delete-collab', to: 'collaborator#destroy', as: :delete_collab
    match '/add-viewer', to: 'viewer#create', as: :create_viewer
    match '/delete-delete-viewer', to: 'viewer#destroy', as: :delete_viewer
  end

  match 'about', to: 'welcome#about', via: :get
  root :to => 'welcome#index'
end