Rails.application.routes.draw do
  root 'dashboard#index'

  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create', as: :create_session

  get 'signup', to: 'signup#new', as: :new_signup
  post 'signup', to: 'signup#create', as: :signup
end
