Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :registrations, only: [:create]
      resources :sessions, only: [:create]
      resources :test, only: [:index]
      resources :workspaces, only: [:index, :show, :create, :destroy]
      # modifies the reservation index route to accept an id since there is no longer a current_user object
      resources :reservations, only: [:index, :create] do
        collection do
          get ':id', action: :index
        end
      end
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
