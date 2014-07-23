class UsersController < ApplicationController

  def index
    ultimate_matches
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

  ## LISTS CURRENT USER LIFESTYLE PREFERENCES AS OBJECTS ##
  # def all_lifestyles
  #   current_user.lifestyles.each do |lifestyle|
  #     lifestyle
  #   end
  # end


  ## LISTS CURRENT USER LIFESTYLE TYPES INDIVIDUALLY AND SAVES IT INTO ARRAY TYPE##
  def lifestyle_types
    # type = []
    # all_lifestyles.each do |l|
    #   type << l.types
    # end
    # type
    current_user.lifestyles.map(&:types)
  end

  ## MATCHES CURRENT USER LIFESTYLE_PREF WITH USERS LIFESTYLE ##

  def ultimate_matches
    # matches = []
    # basic_matches.each do |m|
    #   lifestyle_types.each do |t|
    #     if m.deet.lifestyle == t
    #       matches << m          
    #     end
    #   end
    # end
    # @user = matches
    # basic_matches.joins(:deet).where(lifestyles: lifestyle_types)
    @user = Deet.where(lifestyle: lifestyle_types).where(user: basic_matches).map(&:user)
  end

  # LISTS CURRENT USER FIRST DATE PREFERENCES AS OBJECTS ##
  # def all_first_dates
  #   current_user.first_dates.each do |first_dates|
  #     first_dates
  #   end
  # end

  ## LISTS CURRENT USER FIRST DATE TYPES INDIVIDUALLY AND SAVES IT INTO ARRAY TYPE##
  # def first_date_types
  #   type = []
  #   all_first_dates.each do |f|
  #     type << f.types
  #   end
  #   type
  # end


# we have a method to filter current_user first_date as objects (all_first_dates)
# we have a method to filter all_first_dates down to an array of first_date.types
# we need a method to loop through each user from lifestyle_matches and store their first_date.types in an array
# we need a method to loop through that array of lifestyle_matches first_date.types and compare it with current_user first_date_types
# we need to loop through lifestyle_matches

  ## LISTS ALL USERS FROM LIFESTYLE_MATCHES AND SAVES FIRST_DATE.TYPES INTO ARRAY TYPE##
  # def first_date_matches
  #   users = []
  #   lifestyle_matches.each do |m|
  #     # m.first_dates.each do |f|
  #     #       binding.pry
  #       if m.first_dates.select{|fd| fd.types == "drinks"}
  #         user << m
  #       end
  #     end
  #   end
  #   users
  # end

  # def ultimate_matches
  #   @user = first_date_matches  
  # end




end




   # def ultimate_matches
  #   @user = basic_matches[0].deet.where(:lifestyle => "chill")

  #   #where user id matches basic matches user id && lifestyle matches current user
  # end

  # def type_match(chill)
  #   matches = []
  #   basic_matches.each do |match|
  #     if 'type' == match.deets.lifestyle
  # end

## FILTERS BASIC MATCHES BASED ON LIFESTYLE ##
#   def ultimate_matches
#     @user = basic_matches.where( => lifestyle_matches)
#   end


  # if current_user.preference.gender_pref == 'female'
  #   @user = User.where(:gender => 'female')
  # elsif current_user.preference.gender_pref == 'male'
  #   @user = User.where(:gender => 'male')
  # else
  #   @user = User.all
  # end

  # def self.gender_matches(user)
  #   where(:gender => user.preference.gender_pref)
  # end
#
#   def self.age_matches(user)
#     User.where('users.age >= ? AND users.age < ?', user.preference.min_age, user.preference.max_age)
#   end
#
#   # def self.activity_matches(user)
#   #   User.joins(:preference).where('preferences.activity_type_id = ? AND user.id != ?', user.preference.activity_type.id, user.id)
#   # end
#
#   def male?
#     self.gender == 'male'
#   end
#
#   def female?
#     self.gender == 'female'
#   end
#
#   def self.find_matches(user)
#     u = gender_matches(user).age_matches(user)
#     # .activity_matches(user)
#   end
# end
