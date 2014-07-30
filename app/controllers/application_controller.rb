class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  protected

  def restrict_access
    if !current_user
      flash[:alert] = "You must fill in your details first."
      redirect_to new_preference_path
    end
  end

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

  def google_search
    @client = GooglePlaces::Client.new('AIzaSyCoasaICICKYybkFQtEZtA4jHK2a7tnHSw')
    @first_dates = @client.spots(-33.8670522, 151.1957362, :types => ['restaurant','food'])
    @hash = JSON.parse(@first_dates.to_json).first
    @name = @hash["name"]
  end

  private

  def authorize
    redirect_to login_url, alert: "Not authorized" if current_user.nil?
  end

  helper_method :google_search
  helper_method :search
  helper_method :current_user
  
end

