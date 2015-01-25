Rails.application.routes.draw do
  root 'dashboard#index'

  # Login
  get  'login',  to: 'sessions#new', as: :login
  post 'login',  to: 'sessions#create', as: :create_session
  get  'logout', to: 'sessions#destroy', as: :logout

  # Signup
  get  'signup', to: 'signup#new', as: :new_signup
  post 'signup', to: 'signup#create', as: :signup

  # Edit account
  resource :account, only: [:show, :edit, :update]

  # Other users
  resources :users, only: [:index, :show] do
    get :follow, on: :member
    get :unfollow, on: :member
  end
end
