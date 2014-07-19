Rails.application.routes.draw do

  resources :deets

  resources :users

  resources :preferences

  resources :sessions, only: [:new, :create, :destroy]

  root to: 'preferences#new'

end
