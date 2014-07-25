class UsersController < ApplicationController

  def index
    ultimate_matches
    # liked?
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
      session[:user_id] = @user.id
      redirect_to new_preference_path, notice: "Welcome aboard, #{@user.username}!"
    else
      render :new
    end
  end

  def edit
  end

  protected

  def user_params
    params.require(:user).permit(
      :username, :password, :img, :age, :gender, :bio)
  end

  ## GENDER AND AGE MATCHES ##
  def basic_matches
    User.where(:gender => current_user.preference.gender_pref,
      :age => current_user.preference.min_age..current_user.preference.max_age) 
  end


  ## LISTS CURRENT USER LIFESTYLE TYPES INDIVIDUALLY AND SAVES IT INTO ARRAY##
  def lifestyle_types
    current_user.lifestyles.map(&:types)
  end

  ## LISTS CURRENT USER FIRST DATES ##
  def first_dates_types
    current_user.first_dates.map(&:types)
  end

  ## LISTS CURRENT USER FIRST DATE IDS ##
  def first_date_types_id
    current_user.first_date_prefs.map(&:first_date_id)
  end

  ## MATCHES CURRENT USER LIFESTYLE_PREF WITH USERS LIFESTYLE RETURNS LIFESTYLE MATCHES ##
  def lifestyle_matches
    @user = Deet.where(lifestyle: lifestyle_types).where(user: basic_matches).map(&:user_id)
  end


  ## LISTS ALL USER IDS WITH SAME DATE PREFERENCES AS CURRENT USER ##
  def first_date_match_user_ids
    @user = FirstDatePref.where(first_date_id: first_date_types_id).map(&:user_id)
  end

  ## APPLIES PREVIOUSLY FILTERED USERS BY DATE MATCH USER IDS ##
  def ultimate_matches
    @user = User.where(id: first_date_match_user_ids).where(id: lifestyle_matches)
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