Rails.application.routes.draw do

  root 'homes#show'
  resource :dashboard, only: [:show]
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]
  resources :documents, only: [:create, :show]
end
