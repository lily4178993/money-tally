Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'registrations' }

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  authenticated :user do
    root "groups#index", as: :authenticated_root # Authenticated root path
    get '/profile', to: 'users#profile'
    get '/profile/edit', to: 'registrations#edit', as: :edit_profile
    get '/statistics', to: 'users#statistics'
  end

  root "splash#index" # Default root path

  resources :users
  resources :groups, only: [:index, :show, :new, :create, :destroy] do
    resources :expenses, only: [:new, :create, :destroy]
  end
end
