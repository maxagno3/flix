Rails.application.routes.draw do
  resources :genres
  root "movies#index"
  resources :movies do
    resources :reviews
    resources :favs
  end
  resource :session, only: [:new, :create, :destroy]
  resources :users
  get "signup" => "users#new"
  get "movies/filter/:filter" => "movies#index", as: :filtered_movies
end
