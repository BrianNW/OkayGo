Rails.application.routes.draw do

  resources :more, only: [:new, :create, :update, :edit]

  get 'message/index'

  get 'message/create'

  resources :likes
  resources :flags, only: [:show, :new, :create, :destroy]

  resources :deets
  resources :images

  resources :users
  get 'matches', to: 'users#matches', as: 'matches'
  get 'first_date/:chatid', to: 'users#first_date', as: 'first_date'
  get 'my_dates', to: 'users#my_dates', as: 'my_dates'
  post 'accept_date/:user_date_id', to: 'users#accept_date', as: 'accept_date'

  get 'getChatID/:otheruserid', to: 'users#chatid', as:
  'chatid'

  get 'getUserInfo/:user_id/:chatid', to: 'users#userinfo', as:
  'userinfo', :defaults => { :format => :js }

  get 'my_profile', to: 'users#my_profile', as: 'profile'
  get 'deets/:id' => 'deets#show'

  resources :preferences
  get 'lifestyle_firstdate', to: 'preferences#lifestyle_firstdate', as: 'prefs'
  post 'lifestyle_firstdate', to: 'preferences#create_lifestyles_firstdates', as: 'create_prefs'

  resources :sessions, only: [:new, :create, :destroy]

  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

#   match "/application.manifest" => Rails::Offline

# #   match "/application.manifest" => Rails::Offline, :via => [:get, :post]
# #   offline = Rack::Offline.configure do
# #   cache "app/views/layouts/application.html.erb"
# #   cache "app/views/users/index.html.erb"

# #   public_path = Rails.public_path
# #   Dir[public_path.join("javascripts/*.js")].each do |file|
# #     cache file.relative_path_from(public_path)
# #   end

# #   network "/"
# # end

#   # if Rails.env.production?
#   #   offline = Rack::Offline.configure :cache_interval => 120 do
#   #     cache ActionController::Base.helpers.asset_path("application.css")
#   #     cache ActionController::Base.helpers.asset_path("application.js")
#   #     cache ActionController::Base.helpers.view_path("index.html.erb")
#   #     # cache other assets
#   #     network "/"
#   #   end
#   #   match "/application.manifest" => offline
#   # end

  root to: 'deets#index'

end
