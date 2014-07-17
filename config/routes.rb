Rails.application.routes.draw do

  resources :users

  resources :preferences

  resources :sessions, only: [:new, :create]

end 
