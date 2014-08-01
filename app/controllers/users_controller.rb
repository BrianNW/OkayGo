class UsersController < ApplicationController

  before_filter :authorize, only: [:edit, :update]
  helper_method :mid_point_geolocation

  def index
    #TO RENDER DEET MODAL
    ultimate_matches
    final_mutual_matches

    @deet = Deet.find(current_user.deet)
    @preference = current_user.preference
    @first_date = FirstDate.all
    @lifestyle = Lifestyle.all
    # @first_date = current_user.first_dates
    # @lifestyle = current_user.lifestyles
  end

  def matches
    #TO RENDER DEET MODAL
    @deet = Deet.find(current_user.deet)
    final_matches
    @room = Array.new(5){rand 10}.join.to_i
  end

  def chatid

      other_user_id = (params[:otheruserid]).to_i

      @chat_code = ("#{current_user.id}"+ "#{other_user_id}").to_i

      # this query finds current_user's like row
 @current_user_likes = Like.where(user_id: current_user, target_id: other_user_id).first

 @current_user_likes.update_attribute(:code_chat, @chat_code)

      # this query finds other user like row
 @current_user_liked_by = Like.where(user_id: other_user_id, target_id: current_user).first

 @current_user_liked_by.update_attribute(:code_chat, @chat_code)

  urlcode = {:chatID => @chat_code}

  render :json => urlcode.to_json

  end

  # THIS GRABS THE FOLLOWING:
  # current_user img + username
  # mutual like img + username
  def userinfo

    # turns code_chat into integer
    @code_chat = (params[:chatid]).to_i

    # finds Likes based on code_chat id
    chat_data = Like.find_by(code_chat: @code_chat)

    # finds Users based on chat_data query
    @user_data = User.where(id: [chat_data.target_id, chat_data.user_id])

    # formats javascript
    respond_to do |format|
      format.js { render 'chat.js.erb' }
    end
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
      puts "THE USER ID IS #{@user.id}"
      session[:user_id] = @user.id
      redirect_to users_path, notice: "Welcome aboard, #{@user.username}!"
    else
      render :new
    end
  end

  def edit
  end

  def mid_point_geolocation(other_user)
    my_address = current_user.preference.address
    their_address = other_user.preference.address
    mid_point = Geocoder::Calculations.geographic_center([my_address, their_address])
  end


  protected


  # def banned_users
  #   if current_user.flags.length
  # end

  def user_params
    params
      .require(:user)
        .permit(:username, :password, :img, :age, :gender, :bio, 
          { :preference => [ :max_age, :min_age, :gender_pref, :address ] },
          { :deet => [ :lifestyle, :image, :about_me, :profession ] }
        )
  end

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
