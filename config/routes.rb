# config/routes.rb
Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :scripts, only: %i[index show new create update] do
    member do
      # get :location
      resources :locations, only: %i[show create update]
      resources :plans, only: %i[show create update]
    end
  end

  resources :blueprints, only: %i[index show]

  patch '/scripts/:id', to: 'scripts#update'
end
