class DeetsController < ApplicationController

  before_filter :authorize, only: [:edit, :update]

  def index
  end

  def show
    @user = User.find(params[:id])
    @deet = @user.deet
    @preference = @user.preference.id
    # search
    # @date_sample = user_first_date_array.sample
  end

  def new
    @deet = Deet.new
  end

  def create
    @deet = Deet.new(deet_params)
    # @deet.user_id = current_user.id

    if @deet.save
      session[:deet_id] = @deet.id
      redirect_to users_path, notice: "Deet created successfully!"
    else
      render :new
    end
  end

  def edit
    @deet = Deet.find(current_user.deet)
  end

  def update
    @deet = Deet.find(current_user.deet.id)

    if @deet.update_attributes(deet_params)
      redirect_to users_path, notice: 'Done!'
    else
      render :edit
    end
  end

  protected

    def deet_params
      params.require(:deet).permit(:about_me, :lifestyle, :profession, :img)
    end

end
