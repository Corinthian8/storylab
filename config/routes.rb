# config/routes.rb
Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :scripts, only: %i[index show new create update] do
    resource :location, only: %i[show]
  end

  resources :blueprints, only: %i[index show]

  patch '/scripts/:id', to: 'scripts#update'
end


# resources :blueprints, only: %i[index show]
# resources :scripts, only: %i[index show new create update]
