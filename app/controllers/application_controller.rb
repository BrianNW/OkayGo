class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def search
    @user = current_user

    parameters = { term: @user.first_dates.collect{ |x| x.types}.sample, limit: 1 }
    @first_dates = Yelp.client.search('Vancouver', parameters)
    @hash = JSON.parse(@first_dates.to_json)
    @business_name = @hash["businesses"][0]["name"]
    @img = @hash["businesses"][0]["image_url"]
  end

  helper_method :search
  helper_method :current_user
  
end
