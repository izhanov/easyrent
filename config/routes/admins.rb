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
