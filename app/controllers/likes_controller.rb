class LikesController < ApplicationController
  def show
  end

  def new
    @like = Like.new
  end

  def create
    @like = current_user.likes.create({:target_id => params[:target_id]})
    @like.user_id = current_user.id

    if @like.save
      redirect_to users_path, notice: "Like created successfully!"
    else
      render :new
    end
  end

  def destroy
  end

  # def likes_params
  #   params.require(:like).permit(:user_id, :target_id)
  # end
end
