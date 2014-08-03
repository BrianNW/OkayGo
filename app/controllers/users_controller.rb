class UsersController < ApplicationController

  before_filter :authorize, only: [:edit, :update]

  def index
    # MATCHING ALGORITHMS
    ultimate_matches
    final_mutual_matches

    # RENDERED IN DEET MODAL
    @deet = Deet.find(current_user.deet)

    # RENDERED IN PREFERENCES MODAL
    @preference = current_user.preference
    @first_date = FirstDate.all
    @lifestyle = Lifestyle.all
  end

  def matches
    # MATCHING ALGORITHMS
    final_matches

    # RENDERED IN DEET MODAL
    @deet = Deet.find(current_user.deet)
    # @chat = Like.where(user_id: user.id, target_id: current_user).first.code_chat


  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # FIXME: Assumes that these 2 exist in the session. 
      # Need to make sure that user has created these (before_filters)
      @deet = Deet.find_by(id: session[:deet_id]).update(user: @user)
      @preference = Preference.find_by(id: session[:preference_id]).update(user: @user)
      session[:user_id] = @user.id
      redirect_to new_preference_path, notice: "Welcome aboard, #{@user.username}!"
    else
      render :new
    end
  end

  def edit
  end

  # JSON ROUTES

  def chatid
    # SAVES CHAT CODE TO DATABASE

    # converts otheruserid from string to integer
    other_user_id = (params[:otheruserid]).to_i

    # creates chat code
    @chat_code = current_user.id+ other_user_id

    # find user as object
    other_user = User.find(other_user_id)

    # grabs longitude and latitude
    longitude =  mid_point_geolocation(other_user)[1]
    latitude = mid_point_geolocation(other_user)[0]

    # current user saves chat code in database
    # current user saves midpoint in database
    @current_user_likes = Like.where(user_id: current_user, target_id: other_user_id).first
    @current_user_likes.update_attributes(:code_chat => @chat_code, :longitude => longitude, :latitude => latitude)

    # other user saves chat code in database
    # other user saves midpoint in database
    @current_user_liked_by = Like.where(user_id: other_user_id, target_id: current_user).first
    @current_user_liked_by.update_attributes(:code_chat => @chat_code, :longitude => longitude, :latitude => latitude)

    # sends data as json
    urlcode = {:chatID => @chat_code}
    render :json => urlcode.to_json
  end

  def userinfo
    # SENDS INFO TO NODE.JS

    # turns code_chat into integer
    @code_chat = (params[:chatid]).to_i

    # finds likes based on code chat id
    chat_data = Like.find_by(code_chat: @code_chat)

    # finds users based on chat data query
    @user_data = User.where(id: [chat_data.target_id, chat_data.user_id])

    # sends data as raw javascript
    respond_to do |format|
      format.js { render 'chat.js.erb' }
    end
  end

  def first_date
    # turns code_chat into integer
    @code_chat = (params[:chatid]).to_i
    # @user = User.find(params[:id])

    # finds likes based on code chat id
    chat_data = Like.where(code_chat: @code_chat).first

    @latitude = chat_data.latitude
    @longitude = chat_data.longitude

    first_array = User.find(chat_data.user_id).first_dates.map(&:types)
    second_array = User.find(chat_data.target_id).first_dates.map(&:types)
    
    @date_type = (first_array & second_array).sample

    google_search
    random_date

  end

  protected

  def google_search
    @client = GooglePlaces::Client.new('AIzaSyCoasaICICKYybkFQtEZtA4jHK2a7tnHSw')
    @first_dates = @client.spots(@latitude, @longitude, :types => ['restaurant', @date_type])
    @hash = JSON.parse(@first_dates.to_json).first
    @name = @hash["name"]
    @address = @hash["vicinity"]
    @icon = @hash["icon"]
  end

  def random_date
    @day = Date.today+(7*rand())
    @time = "7:00PM"
   
    if @date_type == "drinks"
      @message = "Your date is on #{@day} at"
    end
  end


  def user_params
    # params.require(:user).permit(
    #   :username, :password, :img, :age, :gender)
    params.require(:user).permit(:username, 
      :password, :password_confirmation, :img, :age, :gender,
      :preference_attributes => [:max_age, :min_age, :gender_pref, :address],
      :deet_attributes => [:lifestyle, :about_me, :profession]
    )
    # params.require(:preference).permit( :max_age, :min_age, :gender_pref, :address)
    # params.require(:deet).permit(:lifestyle, :about_me, :profession)
  end

  def mid_point_geolocation(other_user)
    my_address = current_user.preference.address
    their_address = other_user.preference.address
    mid_point = Geocoder::Calculations.geographic_center([my_address, their_address])
  end

  # def banned_users
  #   if current_user.flags.length
  # end

  ##+++ GENDER AND AGE MATCHES +++##
  def basic_matches
    User.where(:gender => current_user.preference.gender_pref,
      :age => current_user.preference.min_age..current_user.preference.max_age)
  end

  ####--- MUTUTAL GENDER AND AGE MATCHES ---####
  def mutual_basic_matches
    Preference.where('gender_pref = ? AND min_age <= ? AND max_age >= ?', current_user.gender, current_user.age, current_user.age).map(&:user_id)
  end

  ##+++ LISTS CURRENT USER LIFESTYLE TYPES INDIVIDUALLY AND SAVES IT INTO ARRAY +++##
  def lifestyle_types
    current_user.lifestyles.map(&:types)
  end

  ##++ LISTS CURRENT USER FIRST DATES ++##
  def first_dates_types
    current_user.first_dates.map(&:types)
  end

  ##++ LISTS CURRENT USER FIRST DATE IDS ++##
  def first_date_types_id
    current_user.first_date_prefs.map(&:first_date_id)
  end

  ##+++ MATCHES CURRENT USER LIFESTYLE_PREF WITH USERS LIFESTYLE RETURNS LIFESTYLE MATCHES +++##
  def lifestyle_matches
    @user = Deet.where(lifestyle: lifestyle_types).where(user: basic_matches).map(&:user_id)
  end

  # def current_user_lifestyle_id
  #   lifestyle_type = current_user.lifestyle
  #   Lifestyles.where(:types lifestyle_type)(&)
  # end


  ####--- ALL USERS LIFESTYLES ARE PUT IN AN ARRAY ---###
  # def users_lifestyles_array
  #   final_matches.all.map(&:lifestyles)
  # end



  #grabbing the current_user.deet.lifestyle
  #match with types in lifestyles to find what the id would be
  #return lifestyle_id (&:id)
  #list of user_ids from lifestyle_prefs table
  #match user_ids with final matches to return array of user


  def current_user_lifestyle_id
    lifestyle_string = current_user.deet.lifestyle
    Lifestyle.where(types: lifestyle_string).map(&:id)
  end

  def mutual_lifestyle_matches
    @users = LifestylePref.where(lifestyle_id: current_user_lifestyle_id).where(user_id: mutual_first_date_match_user_ids).map(&:user_id)
  end

  def final_mutual_matches
    @user = User.where(id: mutual_lifestyle_matches).where(id: ultimate_match_ids)
  end


  # lifetyle_prefs

  #lifestyle id of current user lifestyle
  # types = Lifestyle.where(:type current_user.lifestyle)(&:lifestyle_id)

  #filter all lifestyle_prefs


  ##+++ LISTS ALL USER IDS WITH SAME DATE PREFERENCES AS CURRENT USER +++##
  def first_date_match_user_ids
    @user = FirstDatePref.where(first_date_id: first_date_types_id).map(&:user_id)
  end

  ###--- LISTS USERS WHERE DATE PREF MATCHES CURRENT USER DATE PREFS ---###
  def mutual_first_date_match_user_ids
    @users = FirstDatePref.where(first_date_id: first_date_types_id).where(user_id: mutual_basic_matches).map(&:user_id)
  end

  ##+++ APPLIES PREVIOUSLY FILTERED USERS BY DATE MATCH USER IDS +++##
  def ultimate_matches
    @user = User.where(id: first_date_match_user_ids).where(id: lifestyle_matches)
  end

  ##+++ FINDS IDS OF ULTIMATE MATCHES +++##
  def ultimate_match_ids
    ultimate_matches.map(&:id)
  end

##+++ FINDS USERS FROM ULTIMATE MATCH LIST WHERE TARGET ID IS SAME AS CURRENT USER ID +++##
  def mutual_matches
    Like.where(user_id: ultimate_match_ids).where(target_id: current_user.id).map(&:user_id)
  end

  ##++++ FINDS CURRENTS USERS LIKES AND FILTERS BY MUTUAL MATCHES, RETURNS USER ID +++##
  def mutual_match_user_ids
    likes = Like.where(user_id: current_user.id).where(target_id: mutual_matches).map(&:target_id)
  end

  def final_matches
    @user = User.where(id: mutual_match_user_ids)
  end


  # def flag
  #   (params[:user]).increment!(:flag)
  # end

## METHOD FOR DETERMINING IF THIS USER HAS BEEN LIKED OR NOT (NOT WORKING) ##
  # def liked?
  #   user_likes = current_user.likes.map(&:target_id)
  #   @liked_users = Like.where(user_id: user_likes)(&:user_id)
  # end
  # @liked_users.each do |id|
  # if id == user.id
  # I have liked this user

end
