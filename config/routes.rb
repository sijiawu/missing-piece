Rails.application.routes.draw do
  devise_for :users
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  
  resources :entries, only: [:new, :create, :show, :index, :destroy]
  resources :phrases, only: [:create]
  resources :phrasebook_entries, only: [:index, :create, :destroy]
end
