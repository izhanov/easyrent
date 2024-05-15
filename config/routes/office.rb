namespace :office do
  root to: "car_parks#index"

  devise_for(
    :users,
    controllers: {
      sessions: "office/sessions",
      registrations: "office/registrations",
      passwords: "office/passwords"
    }
  )

  resource :temp_password, only: [:edit, :update], path: "user/temp_password"

  resources :users, only: %i[edit update]

  resources :marks do
    collection do
      get :search
    end
  end

  resources :bookings do
    patch :change_status, on: :member
  end

  namespace :bookings_give_outs do
    resources :upcomings
    resources :completed
  end

  namespace :bookings_acceptance do
    resources :upcomings
    resources :completed
  end

  resources :documents do
    get :download, on: :member
  end

  resources :car_parks_cars, only: %i[index]
  resource :booking_calendar

  resources :comments, only: [:new, :create]

  resources :document_templates do
    get :download, on: :member
  end

  resources :clients do
    collection do
      get :search
    end
  end

  resources :car_parks do
    get :settings, on: :member

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

    resources :additional_services do
      get :booking_checkboxes, on: :collection
    end

    resources :cars do
      resources :offers do
        get :select, on: :collection
      end

      resources :car_insurances
      resources :car_inspections
      resources :consumables do
        resources :consumable_logs
      end

      resources :photos

      get :search, on: :collection
    end
  end

  resources :car_bookings, only: [:index, :new, :create]

  namespace :ajax do
    resources :offers, only: [:show]
    resources :bookings do
      post :calculate, on: :collection
    end

    resources :cars do
      patch :inspect, on: :member
    end
  end
end
