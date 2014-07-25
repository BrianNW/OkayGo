class DeetsController < ApplicationController

  before_filter :restrict_access

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
      @deet = current_user.build_deet(deet_params)
      @deet.user_id = current_user.id

      if @deet.save
        redirect_to new_user_path, notice: "Deet created successfully!"
      else
        render :new
    end
  end

    def edit
      @deet = Deet.find(current_user.deet.id)
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
