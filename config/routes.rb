Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :trainers
  resources :trainers
  patch '/pokemons/capture', to: 'pokemons#capture', as: 'capture'
  patch '/pokemons/damage', to: 'pokemons#damage', as: 'damage'
  patch '/pokemons/heal', to: 'pokemons#heal', as: 'heal'
  resources :pokemons
end
