class UsersController < ApplicationController
  
  def index
    # if current_user.gender_pref == 'female'
    #   @user = User.where(:gender => 'female')
    # elsif current_user.gender_pref == 'male'
    #   @user = User.where(:gender => 'male')
    # else
      @user = User.all
    # end
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
      session[:user_id] = @user.id # auto log in
      redirect_to users_path
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

  def self.gender_matches(user)
    where(:gender => user.preference.gender_pref)
  end

  def self.age_matches(user)
    User.where('users.age >= ? AND users.age < ?', user.preference.min_age, user.preference.max_age)
  end

  # def self.activity_matches(user)
  #   User.joins(:preference).where('preferences.activity_type_id = ? AND user.id != ?', user.preference.activity_type.id, user.id) 
  # end

  def male?
    self.gender == 'male'
  end

  def female?
    self.gender == 'female'
  end

  def self.find_matches(user)
    u = gender_matches(user).age_matches(user)
    # .activity_matches(user)
  end
end
