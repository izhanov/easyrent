Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :admins, controllers: {sessions: "admins/sessions"}
  namespace :admins do
    root to: "welcome#index"
    resources :users
    resources :cities

    resources :catalogues, only: [:index], as: :catalogues do
      collection do
        resources :brands
        resources :marks
      end
    end
  end

  namespace :office do
    root to: "welcome#index"

    devise_for(
      :users,
      controllers: {
        sessions: "office/sessions",
        registrations: "office/registrations",
        passwords: "office/passwords"
      }
    )

    resource :temp_password, only: [:edit, :update], path: "user/temp_password"

    resources :users do
      resources :car_parks do
        resources :cars
      end
    end
  end
end
