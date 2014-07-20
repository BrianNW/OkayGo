class DeetsController < ApplicationController
    
    def index
    end

    def show
      @user = User.find(params[:id])
      @deet = @user.deet.id
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
      @deet = Deet.find(current_user.id)
    end

  protected

    def deet_params
      params.require(:deet).permit(:about_me, :lifestyle, :profession)
    end

end
