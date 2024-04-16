Rails.application.routes.draw do
  devise_for :users

  root 'pokemons#index'

  resources :pokemons, only: [:index, :show]
  resources :types, only: [:index, :show]
  resources :abilities, only: [:index, :show]

  get '/about', to: 'about#show', as: 'about'

  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end

end
