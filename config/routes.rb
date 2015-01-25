Rails.application.routes.draw do
  root 'dashboard#index'

  # Login
  get  'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create', as: :create_session

  # Signup
  get  'signup', to: 'signup#new', as: :new_signup
  post 'signup', to: 'signup#create', as: :signup

  # Edit account
  resource :account, only: [:show, :edit, :update]
end
