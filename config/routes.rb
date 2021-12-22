Rails.application.routes.draw do
  root "movies#index"

  resources :movies, only: [:index]
  namespace :users do
    resources :sessions, only: [:create, :destroy]
  end
end
