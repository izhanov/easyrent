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

  resources :marks do
    collection do
      get :search
    end
  end

  resources :bookings

  resources :clients do
    collection do
      get :search
    end
  end

  resources :car_parks do
    resources :price_ranges do
      resources :price_range_cells
    end

    namespace :rental_rules, as: :rental_rule do
      root to: "welcome#index"

      resource :age_restriction
      resource :driving_experience
      resource :minimal_period
      resources :mileage_limits
    end

    resources :additional_services

    resources :bookings

    resources :cars do
      resources :offers do
        get :select, on: :collection
      end
      get :search, on: :collection
    end
  end
end
