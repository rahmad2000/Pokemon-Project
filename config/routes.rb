Rails.application.routes.draw do
  devise_for :users

  root 'pokemons#index'

  resources :pokemons, only: [:index, :show]
  resources :types, only: [:index, :show]
  resources :abilities, only: [:index, :show]

  get '/about', to: 'about#show', as: 'about'

  # Additional routes can be added below as needed
end
