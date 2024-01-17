Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  authenticated :user do
    root "groups#index", as: :authenticated_root
  end

  root "splash#index"

  resources :users do
    resources :groups, only: [:index, :show, :new, :create, :destroy] do
      resources :expenses, only: [:new, :create, :destroy]
    end
  end
end
