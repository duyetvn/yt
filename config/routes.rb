Rails.application.routes.draw do
  root "movies#index"

  scope(path_names: { new: 'share' }) do
    resources :movies, path: '', only: [:new, :create] do
      collection do
        put :vote
      end
    end
  end

  namespace :users do
    resources :sessions, only: [:create, :destroy]
  end
end
